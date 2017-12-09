import axios from 'axios'
export default {
    axiosInstance (state) {
        const instance = axios.create({
            withCredentials: true,
            validateStatus: status => status < 500
        })
        instance.interceptors.request.use(config => {
            config.headers['access-token'] = state.user.accessToken
            config.headers['client'] = state.user.client
            config.headers['uid'] = state.user.uid
            return config
        })
        return instance
    }
}
