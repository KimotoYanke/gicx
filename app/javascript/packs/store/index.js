import Vue from 'vue'
import Vuex from 'vuex'
import getters from './getters'

import user from './user'
import createPersist from 'vuex-localstorage'

Vue.use(Vuex)
export default new Vuex.Store({
    getters,
    modules: {
        user
    },
    plugins: [createPersist({
        namespace: 'user',
        expires: 30 * 24 * 60 * 60 * 1e3
    })]
})
