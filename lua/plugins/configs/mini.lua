local status_ok, trailspace = pcall(require, "mini.trailspace")
if not status_ok then
  return
end

trailspace.setup()
