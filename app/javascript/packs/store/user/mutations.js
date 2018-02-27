import { parse } from 'date-fns'
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

function setSuccess (state, success) {
    state.success = success
    if (!success) {
        resetToken(state)
    }
}

function setSubjects (state, subjects) {
    state.subjects = subjects.map(s => {
        s.tasks = s.tasks.map(t => {
            t.until = parse(t.until)
            return t
        })
        return s
    })
}

export default {
    setToken,
    resetToken,
    setHomeroom,
    setSuccess,
    setSubjects
}
