export default {
    setToken (state, {accessToken, client, uid}) {
        state.accessToken = accessToken
        state.client = client
        state.uid = uid
    }
}
