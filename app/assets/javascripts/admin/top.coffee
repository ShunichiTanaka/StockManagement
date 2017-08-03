class AdminTopController
  index: ->
    index_summary("nikkei")
    index_summary("jasdaq")
    index_summary("mothers")

  index_summary = (index_name) ->
    $.ajax({
          type: "GET",
          dataType: "json",
          url: "/admin/top/index_to_chart",
          data: { index_name: index_name }
    }).done (data) ->
      ctx = document.getElementById("#{index_name}_chart").getContext("2d")
      new Chart(ctx, {
        type: "line",
        data: data,
        options: {
          title: {
            display: true,
            text: "過去１ヶ月間の遷移",
            position: "bottom"
          },
          legend: {
            display: false
          },
          scales: {
            xAxes: [
              {
                ticks: {
                  beginAtZero: true
                }
              }
            ]
          }
        }
      })
    .fail (data) ->
      $.notify({ icon: "fa fa-ban", message: "データを取得できませんでした。" }, { type: "danger" })
this.StockManagement.admin_top = new AdminTopController
