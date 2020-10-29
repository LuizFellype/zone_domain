class AvailableDomainDatatable < AjaxDatatablesRails::ActiveRecord

  def view_columns
    @view_columns ||= {
      id: { source: "AvailableDomain.id", cond: :eq },
      name: { source: "AvailableDomain.name", cond: :like }
    }
  end

  def data
    records.map do |record|
      {
        id: record.id,
        name: record.name
      }
    end
  end

  def get_raw_records
    AvailableDomain.where(domain_check_history_id: params[:history_id])
  end
end
