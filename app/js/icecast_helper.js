const StringHelper = require('js/string_helper')

let IcecastHelper = {}

IcecastHelper.getSongData = function (successCallback) {
  var xhr = new XMLHttpRequest()
  xhr.timeout = 2000
  xhr.open('GET', 'https://radio.plaza.one/status-json.xsl')
  xhr.onload = () => {
    if (xhr.status === 200) {
      let songData = JSON.parse(xhr.response)
      let artistName = ''
      let songName = ''

      if (songData.icestats && songData.icestats.source && songData.icestats.source.title) {
        const title = songData.icestats.source.title
        if (StringHelper.countOccurrences(title, ' - ') === 1) {
          artistName = title.split(' - ')[0]
          songName = title.split(' - ')[1]
        } else {
          artistName = 'you are tuned in'
          songName = 'to vapor fm'
        }
      }
      successCallback({ artistName: artistName, songName: songName })
    } else {
      console.log('Plaza.one request failed.  Returned status of ' + xhr.status)
    }
  }
  xhr.send()
}

module.exports = IcecastHelper