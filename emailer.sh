#!/bin/bash

send_email() {
    local api_key="$1"
    local from_email="$2"
    local to_email="$3"
    local subject="$4"
    local content="$5"

	echo "send_email started!"
	
    local response=$(curl -w "%{http_code}" -X POST "https://mandrillapp.com/api/1.0/messages/send.json" \
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
    }")

    local body=$(echo "$response" | sed -e 's/.*\(.\{3\}\)$/\1/')
    local status=${response: -3}

    if [ "$status" -eq 200 ]; then
        echo "Email sent successfully!"
        echo "Response: $body"
    else
        echo "Failed to send email."
        echo "Status code: $status"
        echo "Response: $body"
    fi
}


send_email "$@"
