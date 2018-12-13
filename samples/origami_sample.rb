$LOAD_PATH.unshift(File.expand_path("../lib", __dir__))
require "my_origami"

pdf_path = File.expand_path("sample.pdf", __dir__)
#p MyOrigami.read(pdf_path).class
#p MyOrigami.read(pdf_path).methods

#p MyOrigami.revisions(pdf_path).class
#p MyOrigami.revisions(pdf_path).methods
#p MyOrigami.revisions(pdf_path).first.class

#p MyOrigami.revisions(pdf_path).first.class
#p MyOrigami.revisions(pdf_path).map(&:body).map(&:size)

#p MyOrigami.trailers(pdf_path).first.document.revisions.first.trailer.document.class
#p MyOrigami.trailers(pdf_path)

#p MyOrigami.objects(pdf_path).first.map(&:class).uniq


MyOrigami.pages(pdf_path).each.with_index do |page, idx|
  p page.map { |k,v| k.type }
end
