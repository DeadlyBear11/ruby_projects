def stock_picker(array)
    # Find the best buy/sell earning
    dif_arr = []
    array.combination(2) do |pair|
        dif = pair[0] - pair[1]
        dif_arr.push(dif)
    end
    b_earn = dif_arr.min

    # Find the best buy/sell prices
    b_prices = []
    array.combination(2) do |pair|
        b_prices.push(pair) if pair[0] - pair[1] == b_earn
    end

    # Find the best prices days
    b_days = []
    array.each_with_index do |price, index|
        b_prices[0].each do |b_price|
            b_days.push(index) if b_price == price
        end
    end
    b_days
end

prices = [9,8,7,6,1,2,3,4]

p stock_picker(prices)