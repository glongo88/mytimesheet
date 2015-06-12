import org.springframework.cloud.CloudFactory
import org.springframework.cloud.CloudException

//dataSource {
//    pooled = true
//    driverClassName = "com.mysql.jdbc.Driver"
//    dialect = "org.hibernate.dialect.MySQL5InnoDBDialect"
//}

def cloud = null
try {
    cloud = new CloudFactory().cloud
} catch (CloudException) {}

dataSource {
    pooled = false;
    driverClassName = "org.h2.Driver"
    username = "sa"
    password = ""
}


hibernate {
    cache.use_second_level_cache = true
    cache.use_query_cache = false
    cache.region.factory_class = 'org.hibernate.cache.ehcache.EhCacheRegionFactory'
    singleSession = true
    flush.mode = 'manual'
}

environments {
    development {
        dataSource {
            dbCreate = "update" // one of 'create', 'create-drop','update'
            url = "jdbc:h2:file:myHours;MVCC=TRUE;LOCK_TIMEOUT=10000;DB_CLOSE_ON_EXIT=FALSE"
        }
    }
    test {
        dataSource {
            dbCreate = "update"
            url = "jdbc:h2:mem:testDb;MVCC=TRUE;LOCK_TIMEOUT=10000;DB_CLOSE_ON_EXIT=FALSE"
        }
    }

    production {
        dataSource {
            /*dbCreate = "update"
            jndiName = "java:comp/env/externalDatasource"*/
            dbCreate = "update"
            def dbInfo = cloud?.getServiceInfo('myhours-db')
            url = dbInfo?.jdbcUrl
            username = dbInfo?.userName
            password = dbInfo?.password
        }
    }

    /*production {
        dataSource {
            dbCreate = "update"
            url = "jdbc:mysql://localhost:3306/myhours?useUnicode=yes&characterEncoding=UTF-8"
            username = "root"
            password = "95135700"
            pooled = true
            properties {
                maxActive = 50
                maxIdle = 25
                minIdle = 1
                initialSize = 1
                numTestsPerEvictionRun = 3
                maxWait = 10000
                testOnBorrow = true
                testWhileIdle = true
                testOnReturn = true
                validationQuery = "select now()"
                minEvictableIdleTimeMillis = 1000 * 60 * 5
                timeBetweenEvictionRunsMillis = 1000 * 60 * 5
            }
        }
    }*/

}
