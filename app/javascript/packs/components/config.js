const baseUrl = `${location.hostname}${location.port ? ':'+location.port: ''}`
const appConfig = {
  url: `${location.protocol}//${baseUrl}`,
  ws_root: `ws://${baseUrl}/cable`
}
export default appConfig
