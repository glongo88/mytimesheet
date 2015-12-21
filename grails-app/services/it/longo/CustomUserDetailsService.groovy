package it.longo

import grails.plugin.springsecurity.SpringSecurityUtils
import grails.plugin.springsecurity.userdetails.GrailsUserDetailsService
import grails.transaction.Transactional
import it.longo.CustomUserDetails
import it.longo.Utente
import org.springframework.security.core.authority.GrantedAuthorityImpl
import org.springframework.security.core.userdetails.UserDetails
import org.springframework.security.core.userdetails.UsernameNotFoundException

@Transactional
class CustomUserDetailsService implements GrailsUserDetailsService
{

    static final List NO_ROLES = [new GrantedAuthorityImpl(SpringSecurityUtils.NO_ROLE)]

    UserDetails loadUserByUsername(String username, boolean loadRoles) throws UsernameNotFoundException {
        return loadUserByUsername(username)
    }

    UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {

        Utente.withTransaction { status ->
            Utente user = Utente.findByUsername(username)
            if (!user) throw new UsernameNotFoundException(
                    'User not found', username)

            def authorities = user.authorities.collect {
                new GrantedAuthorityImpl(it.authority)
            }
            return new CustomUserDetails(user.username, user.password,
                    user.enabled, !user.accountExpired,
                    !user.passwordExpired, !user.accountLocked,
                    authorities ?: NO_ROLES, user.id, user.nome, user.cognome)
        }
    }

}
