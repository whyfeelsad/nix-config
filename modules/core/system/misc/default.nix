{ config, ... }:
let
  inherit (config.globals) timeZone;
in
{
  time.timeZone = timeZone;
}
