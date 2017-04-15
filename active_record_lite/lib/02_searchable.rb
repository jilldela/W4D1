require_relative 'db_connection'
require_relative '01_sql_object'

module Searchable
  def where(params)
    where_line = params.map { |k,_| "#{k} = ?" }.join(" AND ")
    pars = DBConnection.execute(<<-SQL, params.values)
      SELECT
        *
      FROM
        #{self.table_name}
      WHERE
        #{where_line}
    SQL
    pars.map do |par|
      self.new(par)
    end
  end
end

class SQLObject
  extend Searchable
end
