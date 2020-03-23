# frozen_string_literal: true

module YAMLM
  # YAMLM::CLI
  class CLI
    # @param argv [Array]
    def initialize(argv = [])
      @files = argv
    end

    # @return [void]
    def execute
      puts dump_yaml(
        merge_hash_array(load_texts(merge_texts(read_files(@files))))
      )
    end

    private

    # @param files [Array]
    # @return [Array]
    def read_files(files)
      files.map { |f| File.read(f) }
    end

    # @param texts [Array]
    # @return [Array]
    def merge_texts(texts)
      texts.each_with_object([]) { |t, r| r << r.last.to_s + t }
    end

    # @param texts [Array]
    # @return [Array]
    def load_texts(texts)
      texts.map { |t| YAML.safe_load(t, [], [], true) }
    end

    # @param array [Array]
    # @return [Hash]
    def merge_hash_array(array)
      array.each_with_object({}) { |h, r| deep_merge_hash(r, h) }
    end

    # @param origin_hash [Hash]
    # @param other_hash [Hash]
    # @return [Hash]
    def deep_merge_hash(origin_hash, other_hash)
      origin_hash.merge!(other_hash) do |_key, this_val, other_val|
        if this_val.is_a?(Hash) && other_val.is_a?(Hash)
          deep_merge_hash(this_val.dup, other_val)
        else
          other_val
        end
      end
    end

    # @param hash [Hash]
    # @return [String]
    def dump_yaml(hash)
      YAML.dump(hash.empty? ? nil : hash)
    end
  end
end
