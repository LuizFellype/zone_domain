$ ->
  $('#history-datatable').dataTable
    processing: true
    serverSide: true
    ajax:
      url: '/domain_check_histories'
    pagingType: 'full_numbers'
    columns: [
      {data: 'pattern'}
      {data: 'extension'}
      {data: 'starts_with'}
      {data: 'omit'}
      {data: 'created_at'}
      {data: 'status'}
      {data: 'id', render: (data, type, row, meta) ->
        "<a href='/domain_check_histories/#{data}' class='btn btn-primary'>Show</a>"
      }
    ]

  $('#available-domains-datatable').dataTable
    processing: true
    serverSide: true
    ajax:
      url: '/available_domains'
      data: (data) ->
        data.history_id = $("#available-domains-datatable").data('historyId')
        data
    pagingType: 'full_numbers'
    columns: [
      {data: 'name'}
    ]
