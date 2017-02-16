require "render_anywhere"

class WrestlerPdf
  include RenderAnywhere

  def initialize(wrestler)
    @wrestler = wrestler
  end
 
  def to_pdf
    kit = PDFKit.new(as_html, page_size: 'A4')
    kit.to_file("tmp/wrestler.pdf")
  end
 
  def filename
    "taco.pdf"
  end
 
  def render_attributes
    {
      template: "wrestlers/pdf",
      layout: "wrestler_pdf",
      locals: { wrestler: @wrestler }
    }
  end

  private

  attr_reader :wrestler

  def as_html
    render render_attributes
  end
end