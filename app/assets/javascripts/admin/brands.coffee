class AdminBrandsController
  show: ->
    brand_code = $(".chart")[0].id
    show_stock_price_summary(brand_code)

  show_stock_price_summary = (brand_code) ->
    $.ajax({
          type: "GET",
          dataType: "json",
          url: "/admin/brands/stock_price_to_chart",
          data: { code: brand_code }
    }).done (data) ->
      ctx = document.getElementById("stock_price_chart").getContext("2d")
      brands_data = new Chart(ctx, {
        type: "line",
        data: data,
        options: {
          title: {
            display: true,
            text: "過去１ヶ月間の終値遷移",
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

  $("#check_all_box").click ->
    if $(this).prop "checked"
      $(".checked_item").prop "checked", true
    else
      $(".checked_item").prop "checked", false
this.StockManagement.admin_brands = new AdminBrandsController
