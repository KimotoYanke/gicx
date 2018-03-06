export default {
    checkSignIned ({ commit, dispatch, rootGetters }) {
        rootGetters.axiosInstance
            .get('/auth/validate_token')
            .then(res => {
                commit('setSuccess', !!res.data.success)
                if (res.data.data.homeroom_id !== 0) {
                    dispatch('getHomeroom', res.data.data.homeroom_id)
                } else {
                    dispatch('getSubjectsForTeachers')
                }
            })
            .catch(res => {})
    },
    signOut ({ commit, dispatch }) {
        commit('resetToken')
        dispatch('checkSignIned')
    },
    getHomeroom ({ commit, dispatch, rootGetters, state }, id) {
        rootGetters.axiosInstance.get('/homeroom/' + id).then(res => {
            commit('setHomeroom', {
                grade: res.data.grade,
                department: res.data.department,
                id
            })

            dispatch('getSubjects')
        })
    },
    getSubmissions ({ commit, dispatch, rootGetters, state }, id) {
        rootGetters.axiosInstance.get('/submission?task_id=' + id).then(res => {
            commit('setSubmissions', {submissions:res.data, taskId: id})
        })
    },
    getSubjects ({ commit, dispatch, rootState, rootGetters }) {
        const homeroomId = rootState.user.homeroomId
        rootGetters.axiosInstance
            .get(`/subject?homeroom_id=${homeroomId}`)
            .then(res => {
                commit('setSubjects', res.data)
                dispatch('getTasks')
            })
    },
    getSubjectsForTeachers ({ commit, dispatch, rootState, rootGetters, getters }) {
        const uid = rootState.user.uid
        rootGetters.axiosInstance
            .get(`/subject?teacher=${uid}`)
            .then(res => {
                commit('setSubjects', res.data)
                for(let t of getters.tasks){
                    dispatch('getSubmissions', t.id)
                }
            })
    },
    getTasks ({ commit, state, rootState, rootGetters }) {}
}
