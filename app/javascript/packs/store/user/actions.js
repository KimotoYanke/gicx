export default {
    checkSignIned ({commit, rootGetters}) {
        rootGetters.axiosInstance.get('/auth/validate_token').then(res => {
            commit('setSuccess', !!res.data.success)
        }).catch(res => {
        })
    },
    signOut ({commit, dispatch}) {
        commit('resetToken')
        dispatch('checkSignIned')
    }
}
