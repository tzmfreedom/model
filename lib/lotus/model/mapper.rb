require 'lotus/model/mapping'

module Lotus
  module Model
    class Mapper
      def initialize(&blk)
        @collections = {}
        instance_eval(&blk) if block_given?
      end

      def collection(name, &blk)
        if block_given?
          @collections[name] = Mapping::Collection.new(name, &blk)
        else
          @collections[name] or raise Mapping::UnmappedCollectionError.new(name)
        end
      end

      def load!
        @collections.each {|_, collection| collection.load! }
        self
      end
    end
  end
end