class DomainCheckHistoryDatatable < AjaxDatatablesRails::ActiveRecord

  def view_columns
    @view_columns ||= {
      id: { source: "DomainCheckHistory.id", cond: :eq },
      pattern: { source: "DomainCheckHistory.pattern", cond: :like },
      extension: { source: "DomainCheckHistory.extension", cond: :like },
      starts_with: { source: "DomainCheckHistory.starts_with", cond: :like },
      omit: { source: "DomainCheckHistory.omit", cond: :like },
      created_at: { source: "DomainCheckHistory.created_at", cond: :like },
      status: { source: "DomainCheckHistory.status", cond: :like }
    }
  end

  def data
    records.map do |record|
      {
        id: record.id,
        pattern: record.pattern,
        extension: record.extension,
        starts_with: record.starts_with,
        omit: record.omit,
        created_at: record.created_at,
        status: record.status,
        DT_RowId: record.id
      }
    end
  end

  def get_raw_records
    DomainCheckHistory.all
  end
end
