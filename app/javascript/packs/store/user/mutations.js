function setToken (state, {accessToken, client, uid}) {
    state.accessToken = accessToken
    state.client = client
    state.uid = uid
}

function resetToken (state) {
    setToken(state, {
        accessToken: '',
        client: '',
        uid: ''
    })
}

export default {
    setToken,
    resetToken,
    setSuccess (state, success) {
        state.success = success
        if (!success) {
            resetToken(state)
        }
    }
}
