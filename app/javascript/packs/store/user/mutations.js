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

function setHomeroom (state, {id, grade, department}) {
    state.homeroomId = id
    state.grade = grade
    state.department = department
}

export default {
    setToken,
    resetToken,
    setHomeroom,
    setSuccess (state, success) {
        state.success = success
        if (!success) {
            resetToken(state)
        }
    }
}
