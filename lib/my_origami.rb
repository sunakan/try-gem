require "origami"

module MyOrigami
  def annotations(pdf_path)
    # doc.class #=> Origami::PDF
    # doc.revisions #=> [ Origami::PDF::Revision, Origami::PDF::Revision, ...]
    doc = Origami::PDF.read(pdf_path, verbosity: Origami::Parser::VERBOSE_QUIET)
    doc.revisions.each do |revision|
      # [:Catalog, :PageTreeNode, :Page, :ContentStream, :Font, :Array,
      #  :Dictionary, :FontDescriptor, :ExtGState, :TrueType, :ImageXObject,
      #  :FormXObject, :Link, :Metadata, :Stream, :FontStream, :XRefStream]
      revision.body.values.map(&:solve).group_by(&:type)[:Page].to_a
        .map{ |v| v.solve.annotations }
        .each.with_index { |annotations, idx|
          if idx == 1 || idx == 2
            p annotations.first.solve.value
          end
        }
    end
    #doc.pages.each do |page|
    #  p page.class
    #  p page.solve.no
    #end
  end

  module_function :annotations
end
