class OrderPdf < Prawn::Document
  def initialize(order)
    super(page_size: "A4", top_margin: 20, bottom_margin: 10, left_margin: 40, right_margin: 40)
    @order = order
    @customer = order.customer
    
    font_path = Rails.root.join("vendor/assets/fonts/NotoSans-Regular.ttf")
    bold_path = Rails.root.join("vendor/assets/fonts/NotoSans-SemiBold.ttf")
    
    if File.exist?(font_path)
      font_families.update("NotoSans" => {
        normal: font_path,
        bold: bold_path # You can add a -Bold.ttf version here too
      })
      font "NotoSans"
    end
    
    generate_invoice
  end

  def generate_invoice
    logo_path = Rails.root.join("public", "logos", "logo-orange.png")
    
    float do
      if File.exist?(logo_path)
        image logo_path, width: 100
      end
    end
    move_down 35
    # Header Section
    text "Balaji Layout, Magadi Main Road", size: 10
    text "+91 7353328625", size: 10
    # move_down 20

    # Invoice Info Grid
    bounding_box([370, cursor + 30], width: 150) do
      text "INVOICE NO:      #{@order.invoice_number}", style: :bold, size: 10
      text "DATE:                     #{@order.order_date&.strftime('%d %b %Y')}", size: 10
    end
    
    # move_down 20
    # stroke_horizontal_rule
    move_down 15

    # Customer & Category Info
    column_box([0, cursor], columns: 2, width: bounds.width) do
      text "Bill To:", style: :bold, size: 12 #, color: "666666"
      text @customer&.name || "Guest Customer", size: 10, style: :bold
      text @customer&.business_name, size: 10 #, style: :bold
      text "+91 #{@customer&.phone}" || "N/A", size: 10
      
      # next_column
      
      # text "DELIVERY TYPE:", style: :bold, size: 10, color: "666666"
      # text @order.delivery_type&.titleize || "Standard"
    end

    move_down 5

    # Line Items Table
    line_items_table
    
    # Totals
    move_down 5
    stroke_horizontal_rule
    move_down 5
    draw_totals
    
    # Footer
    move_cursor_to 20
    text "Thank you for doing business with us.", align: :center, size: 8
  end

  def line_items_table
    table_data = [["ITEM", "PRICE", "QTY", "SUBTOTAL"]]
    @order.order_items.each do |item|
      table_data << [
        item.item.name,
        "#{item.price_at_order}",
        "#{item.quantity} #{item.item.unit}",
        "#{item.quantity * item.price_at_order}"
      ]
    end

    table(table_data, position: :left, width: bounds.width, header: true) do
      row(0).font_style = :bold
      row(0).background_color = "f2f2f2"
      # cells.padding = 1
      cells.border_width = 0
      cells.style :align => :left
      cells.size = 10
      column(3).align = :right

      # cells.borders = [:bottom]
      # cells.padding = [6, 3]
      # column(3).padding = [6,20]
    end
  end

  def draw_totals
    bounding_box([320, cursor], width: 200) do
      table([
        ["Subtotal:", "₹#{@order.sub_total}"],
        ["Delivery Charge:", "₹#{@order.delivery_charge || 0}"],
        # ["Discount:", "- ₹#{@order.discount || 0}"],
        ["Total:", "₹#{@order.total_amount}"]
      ], width: 200) do
        cells.borders = []
        column(1).align = :right
        row(2).font_style = :bold
        # row(3).size = 14
        row(2).text_color = "008000"
      end
    end
  end
end