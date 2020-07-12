import axios from 'axios'

const csrfToken = document.head.querySelector('[name~=csrf-token][content]')

const ax = axios.create({
  headers: {
    common: {
      'X-CSRF-Token': csrfToken ? csrfToken.content : '',
    },
  },
})

export default ax
