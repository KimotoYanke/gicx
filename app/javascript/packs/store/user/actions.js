export default {
    checkSignIned ({commit, dispatch, rootGetters}) {
        rootGetters.axiosInstance.get('/auth/validate_token').then(res => {
            commit('setSuccess', !!res.data.success)
            dispatch('getHomeroom', res.data.data.homeroom_id)
        }).catch(res => {
        })
    },
    signOut ({commit, dispatch}) {
        commit('resetToken')
        dispatch('checkSignIned')
    },
    getHomeroom ({commit, dispatch, rootGetters, state}, id) {
        rootGetters.axiosInstance.get('/homeroom/' + id).then(res => {
            commit('setHomeroom', {
                grade: res.data.grade,
                department: res.data.department,
                id
            })

            dispatch('getSubjects')
        })
    },
    getSubjects ({commit, dispatch, rootState, rootGetters}) {
        const homeroomId = rootState.user.homeroomId
        rootGetters.axiosInstance.get(`/subject?homeroom_id=${homeroomId}`)
            .then(res => {
                commit('setSubjects', res.data)
                dispatch('getTasks')
            })
    },
    getTasks ({commit, state, rootState, rootGetters}) {

    }
}
