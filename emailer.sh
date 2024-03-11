send_email() {
    local api_key="$1"
    local from_email="$2"
    local to_email="$3"
    local subject="$4"
    local content="$5"

    curl -X POST "https://mandrillapp.com/api/1.0/messages/send.json" \
    -H "Content-Type: application/json" \
    -d "{
      \"key\": \"${api_key}\",
      \"message\": {
        \"from_email\": \"${from_email}\",
        \"to\": [
          {
            \"email\": \"${to_email}\",
            \"type\": \"to\"
          }
        ],
        \"autotext\": \"true\",
        \"subject\": \"${subject}\",
        \"html\": \"${content}\"
      }
    }"
}
