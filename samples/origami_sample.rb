$LOAD_PATH.unshift(File.expand_path("../lib", __dir__))
require "my_origami"

pdf_path = File.expand_path("sample.pdf", __dir__)
MyOrigami.annotations(pdf_path)
