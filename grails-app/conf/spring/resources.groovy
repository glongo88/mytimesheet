import it.longo.CustomUserDetailsService

// Place your Spring DSL code here
beans = {
    userDetailsService(CustomUserDetailsService)
    cloudFactory(org.springframework.cloud.CloudFactory)
}
