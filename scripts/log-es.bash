#!/bash/bin

# Shows log messages from elastic search serilog sink for today

# More indexes can be found with: `curl localhost:9200/_cat/indices?v`

function es_todays_logs {
    curl "localhost:9200/log-*-$(date --iso)/_search?pretty" \
        -H 'Content-Type: application/json' \
        -d '{"query": {"match_all": {}}, "_source": ["@timestamp", "level", "message"]}'
}
