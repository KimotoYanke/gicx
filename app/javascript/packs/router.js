import VueRouter from 'vue-router'
import App from './pages/main.vue'
import SignIn from './pages/sign-in.vue'
import Task from './pages/task.vue'

const routes = [
  { path: '/', component: App },
  { path: '/sign_in', component: SignIn },
  { path: '/task/:subject/:task', component: Task }
]

export default new VueRouter({
  routes
})
