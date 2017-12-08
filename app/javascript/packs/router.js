import VueRouter from 'vue-router'
import App from './pages/main.vue'
import SignIn from './pages/sign-in.vue'

const routes = [
    { path: '/', component: App },
    { path: '/sign_in', component: SignIn }
]

export default new VueRouter({
    routes
})
