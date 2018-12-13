require "origami"

# doc.class #=> Origami::PDF
# doc.revisions #=> [ Origami::PDF::Revision, Origami::PDF::Revision, ...]
# [:Catalog, :PageTreeNode, :Page, :ContentStream, :Font, :Array,
#  :Dictionary, :FontDescriptor, :ExtGState, :TrueType, :ImageXObject,
#  :FormXObject, :Link, :Metadata, :Stream, :FontStream, :XRefStream]
module MyOrigami
  # PDFを読み込む
  # @param [String] PDFへのパス
  # @return [Origami::PDF] Origamiで読み込んだ結果
  def read(pdf_path)
    Origami::PDF.read(pdf_path, verbosity: Origami::Parser::VERBOSE_QUIET)
  end

  # PDFが持つリビジョンを取得(PDFのセキュリティの暗号化レベルで変わる?)
  # @param [String] PDFへのパス
  # @return [Array] Origami::PDF::Revisionの配列
  def revisions(pdf_path)
    Origami::PDF.read(pdf_path, verbosity: Origami::Parser::VERBOSE_QUIET)
      .revisions
    #doc.revisions.each do |revision|
    #  revision.body.values.map(&:solve).group_by(&:type)[:Page].to_a
    #    .map{ |v| v.solve.annotations }
    #    .each.with_index { |annotations, idx|
    #      if idx == 1 || idx == 2
    #        p annotations.first.solve.value
    #      end
    #    }
    #end
    #doc.pages.each do |page|
    #  p page.class
    #  p page.solve.no
    #end
  end

  # PDFが持つ各リビジョンのtrailerを取得
  # @param [String] PDFへのパス
  # @return [Array] Origami::Trailerの配列
  def trailers(pdf_path)
    Origami::PDF.read(pdf_path, verbosity: Origami::Parser::VERBOSE_QUIET)
      .revisions.map(&:trailer)
  end

  # PDFが持つ各リビジョンのオブジェクト郡を取得
  # オブジェクトは色々クラスがある
  # Origami::Catalog, Origami::PageTreeNode, Origami::Page, Origami::ContentStream,
  # Origami::Font, Origami::Array, Origami::Dictionary, Origami::FontDescriptor,
  # Origami::Graphics::ExGState, Origami::Font::TrueType, Origami::Graphics::ImageXObject,
  # Origami::Graphics::FormXObject, Annotation::Link, Origami::Metadata, Origami::Stream,
  # Origami::FontStream, Origami::XRefStream...
  # @param [String] PDFへのパス
  # @return [Array] オブジェクトの配列の配列
  def objects(pdf_path)
    Origami::PDF.read(pdf_path, verbosity: Origami::Parser::VERBOSE_QUIET)
      .revisions.map(&:body).map(&:values)
  end

  # PDFの各ページを取得
  # @param [String] PDFへのパス
  # @return [Array] Origami::Pageの配列
  def pages(pdf_path)
    Origami::PDF.read(pdf_path, verbosity: Origami::Parser::VERBOSE_QUIET).pages
  end

  ## PDFの各ページを取得
  ## @param [String] PDFへのパス
  ## @return [Array] Origami::Pageの配列
  #def pages(pdf_path)
  #  Origami::PDF.read(pdf_path, verbosity: Origami::Parser::VERBOSE_QUIET).pages
  #end

  module_function :read, :revisions, :trailers, :objects, :pages
end
