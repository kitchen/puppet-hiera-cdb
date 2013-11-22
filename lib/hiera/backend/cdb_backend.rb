class Hiera
  module Backend
    class Cdb_backend
      def initialize
        require 'libcdb'
        require 'yaml'
        Hiera.debug("cdb_backend initialized")
      end

      def lookup(key, scope, order_override, resolution_type)
        answer = nil
        Backend.datasources(scope, order_override) do |source|
          file = Backend.datafile(:file, scope, source, "cdb") or next
          LibCDB::CDB.open(file) do |cdb|
            answer = cdb[key]
          end
          if answer
            answer = YAML.parse(answer)
            break
          end
        end

        return answer
      end
    end
  end
end



