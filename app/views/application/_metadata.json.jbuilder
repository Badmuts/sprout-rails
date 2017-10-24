json.metadata do |json|
    json.resultset do
        json.count @count
        json.offset @offset
        json.limit @limit
    end
end