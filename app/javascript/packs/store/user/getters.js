export default {
    tasks ({subjects}) {
        return subjects.reduce((a, c) => a.concat(c.tasks.map(t => Object.assign(t, {subject: c.name, homeroom: c.homeroom}))), [])
    },
    isTeacher ({ grade }) {
        return grade === 0
    }
}
