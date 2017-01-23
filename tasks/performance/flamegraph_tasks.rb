require_relative '../helpers/trie'
require_relative 'compression_task'
require_relative 'creation_task'
require_relative 'lookups_partial_word_task'
require_relative 'lookups_scan_task'
require_relative 'lookups_word_task'
require_relative 'lookups_words_within_task'
require_relative 'serialization_compressed_task'
require_relative 'serialization_raw_task'

module Performance
  module FlamegraphTasks
    include Helpers::Trie

    def flamegraph_tasks
      {
        'creation' => flamegraph_creation_task,
        'compression' => flamegraph_compression_task,
        'serialization:raw' => flamegraph_serialization_raw_task,
        'serialization:compressed' => flamegraph_serialization_compressed_task,
        'lookups:word' => flamegraph_lookups_word_task,
        'lookups:partial_word' => flamegraph_lookups_partial_word_task,
        'lookups:scan' => flamegraph_lookups_scan_task,
        'lookups:words_within' => flamegraph_lookups_words_within_task,
      }
    end

    private

    def flamegraph_lookups_scan_task
      lambda do |output|
        task = Performance::LookupsScanTask.new(
          hi: 1,
          help: 1,
          beautiful: 1,
          impressionism: 1,
          anthropological: 1,
        )

        tries.each do |trie|
          task.execute Performance::FlamegraphProfile, trie
        end
      end
    end

    def flamegraph_lookups_words_within_task
      lambda do |output|
        task = Performance::LookupsWordsWithinTask.new 1
        tries.each do |trie|
          task.execute Performance::FlamegraphProfile, trie
        end
      end
    end

    def flamegraph_lookups_partial_word_task
      lambda do |output|
        task = Performance::LookupsPartialWordTask.new 1
        tries.each do |trie|
          task.execute Performance::FlamegraphProfile, trie
        end
      end
    end

    def flamegraph_lookups_word_task
      lambda do |output|
        task = Performance::LookupsWordTask.new 1
        tries.each do |trie|
          task.execute Performance::FlamegraphProfile, trie
        end
      end
    end

    def flamegraph_serialization_compressed_task
      lambda do |output|
        task = Performance::SerializationCompressedTask.new 1
        task.execute Performance::FlamegraphProfile
      end
    end

    def flamegraph_serialization_raw_task
      lambda do |output|
        task = Performance::SerializationRawTask.new 1
        task.execute Performance::FlamegraphProfile
      end
    end

    def flamegraph_compression_task
      lambda do |output|
        task = Performance::CompressionTask.new 1
        task.execute Performance::FlamegraphProfile
      end
    end

    def flamegraph_creation_task
      lambda do |output|
        task = Performance::CreationTask.new 1
        task.execute Performance::FlamegraphProfile
      end
    end
  end
end