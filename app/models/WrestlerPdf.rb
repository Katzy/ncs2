class WrestlerPdf
 
  def initialize(wrestler)
    @wrestler = wrestler
  end
 
  def to_pdf
    kit = PDFKit.new(as_html, page_size: 'A4')
    kit.to_file("#{Rails.root}/public/wrestler.pdf")
  end
 
  def filename
    "weight_card_#{wrestler.first}_#{wrestler.last}_#{wrestler.weight}.pdf"
  end
 
  private
 
    attr_reader :wrestler
 
    def as_html
      render template: "wrestlers/pdf", layout: "wrestler_pdf", locals: { wrestler: wrestler }
    end
end