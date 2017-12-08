input {
file {
    path => "/var/log/containers/{{containerName}}-{{containerId}}*log"
    codec => multiline {
      pattern => "^[^{]"
      what => "previous"
    }
    tags => [ "{{containerId}}" ]
 }
}

output {
 if "{{containerId}}" in [tags]{
   sumologic {
          url => '{sumoUrl}'
          compress => true
          format => "%{message}"
          extra_headers => {
            "X-Sumo-Name" => "{{containerName}}"
            "X-Sumo-Category" => "myappname-{environment}"
            "X-Sumo-Host" => "{{instanceId}}"
          }
   }
 }
}
