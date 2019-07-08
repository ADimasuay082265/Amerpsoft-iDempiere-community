
## Plug-In Development with Maven on Idempiere
## 1. Introduction.
<pre>
This tutorial is brought to you by Luis Amesty from Amerpsoft Consulting. For any question or improvement see me at (User:Luisamesty) or [email](luisamesty@gmail.com) to me.
From versión 1.0 to 5.1 idempiere plugins are based on OSGi Buckminster. From version 6.1 and its successor 6.2, Maven was introduced in order to compile Idempiere trunk and plugins.
With this tutorial i will try to give idempiere users some changes neccessary to carry on this task. Also some tips for easily get final objectives.
</pre>

## 2. Prerequisites.
<pre>
Before start working on Maven plugis, you must install iDempiere developing environment in Eclipse with all requirements that has been detailed explained on tutorial brought to you by Carlos Ruiz from GlobalQSS. 
</pre>
Installing iDempiere:
 https://wiki.idempiere.org/en/Installing_iDempiere
<pre>
Also, you must have your plugings completed migrated on previous Idempiere version 5.1 in order to make changes to them to become Mave plugins. 
</pre>

## 3. OSGi Buckminster plugin sets.
<pre>
Before explaining changes done to special files on previous Java Buckminster plugins, let's see standad structure of iDempiere set of plugins.
.
Normal plugin structure before iDempiere version 6:
    Main Directory  /
                Feature Plugin project/
                Plugin project # 1 /
                Plugin project # 2 /
                ...
                Plugin project # N /
                Fragnment project /
New plugin structure with iDempiere version 6.2:
    Main Directory  /
                Feature Plugin project/
                Plugin project # 1 /
                Plugin project # 2 /
                ...
                Plugin project # N /
                Fragnment project /
                p2.site project /
                p2.targetplatform project /
                pom.xml  (Maven file)

Sample plugin can be cloned from:
</pre>
    Amersoft community plugins:
    https://wiki.idempiere.org/en/Installing_iDempiere
<pre>
Normally, iDempiere users develop plugins for different purposes. Allways it is important to make them independent from trunk, in order to extend base capabilities and features, and future migration to the new versions.
For mor information see:
    Developing plug-ins without affecting the trunk
    https://wiki.idempiere.org/en/Developing_plug-ins_without_affecting_the_trunk
</pre>

### 3.1 Feature plugin project.
<pre>
A feature project is basically a list of plugins and other features which can be understood as a logical separate unit.
Eclipse uses feature projects for the updates manager and for the build process.
</pre>

### 3.2 Plugin project.
<pre>
A plugin project is a Java jar file that contains Java code, resources, and a manifest that describes the bundle and its dependencies. The plugin is the unit of deployment for iDempiere.
</pre>

### 3.3 Fragment project.
<pre>
A fragment plugin project is a Java jar file that contains Java code, resources, and a manifest that makes its contents available to another bundle. And most importantly, a fragment and its host bundle share the same classloader. An example of this kind of project are Extended theme plugins. 
In resume, fragments are used to customize another bundle.
</pre>

## 4. Sample Amerpsoft community plugins.
<pre>
A sample set of plugins will be used, in order to explain changes done to special files on previous Java Buckminster plugins.
When installing iDempiere developing environment, tutorial recommends to have a cloned directory called "myexperiment". In this case plugin sets are located on a same level than "myexperiment" in order to get an easy relative path to idempiere developing source code.
Directory structure:
    idempiere 6.2 /
    myexperiment /
    Amerpsoft-iDempiere-community/
        org.amerpsoft.com.idempiere.feature
        org.amerpsoft.com.idempiere.editors-com
        org.amerpsoft.com.idempiere.themes-com
        org.amerpsoft.com.idempiere.p2.site
        org.amerpsoft.com.idempiere.p2.targetplatform
        pom.xml
</pre>

### 4.1 Feature project: org.amerpsoft.com.idempiere.feature.
<pre>
Feature plugin, includes two plugins, because p2 are not considered on this list. P2 projects are required for maven build only. 
</pre>
pom.xml
<pre>
<project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">
  <modelVersion>4.0.0</modelVersion>
  <artifactId>org.amerpsoft.com.idempiere.feature</artifactId>
  <parent>
  	<groupId>org.idempiere</groupId>
  	<artifactId>org.idempiere.parent</artifactId>
  	<version>6.2.0-SNAPSHOT</version>
  	<relativePath>../../myexperiment/org.idempiere.parent/pom.xml</relativePath>
  </parent>
  <packaging>eclipse-feature</packaging>
</project>
</pre>
feature.xml
<pre>
<?xml version="1.0" encoding="UTF-8"?>
<feature
      id="org.amerpsoft.com.idempiere.feature"
      label="Amerpsoft_community_features"
      version="6.2.0.qualifier">

   <description url="http://www.example.com/description">
      [Enter Feature Description here.]
   </description>

   <copyright url="http://www.example.com/copyright">
      [Enter Copyright Description here.]
   </copyright>

   <license url="http://www.example.com/license">
      [Enter License Description here.]
   </license>

   <plugin
         id="org.amerpsoft.com.idempiere.editors-com"
         download-size="0"
         install-size="0"
         version="0.0.0"
         unpack="false"/>

   <plugin
         id="org.amerpsoft.com.idempiere.themes-com"
         download-size="0"
         install-size="0"
         version="0.0.0"
         fragment="true"
         unpack="false"/>
</feature>
<pre>

Tips:
* Do not put Group ID on pom.xml
* Check parent relative path and version 6.2.0-SNAPSHOT on pom.xml
* Packaging must be "eclipse-feature" on pom.xml
* Artifact ID must be the same (correct sintax) on pom.xml and feature.xml, because eclipse will not detect diffrences. (org.amerpsoft.com.idempiere.feature)
* Included plugin list must concide with global project pom.xml file, and must be the same names (correct sintax). In this case 
    id="org.amerpsoft.com.idempiere.editors-com"
    id="org.amerpsoft.com.idempiere.themes-com" 
* p2 plugins are not included on feature list.
</pre>


### 4.2 Plugin project: org.amerpsoft.com.idempiere.editors-com.
<pre>
This plugin is Extended Location plugin, alredy published. 
It is related with demographics aspects and extended information on Business Partners Locations (Addresses). You can see more information on:
    Extended Location
https://wiki.idempiere.org/en/Plugin:_Extended_Location
</pre>
pom.xml
<pre>
<project xmlns="http://maven.apache.org/POM/4.0.0" 
  xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" 
  xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">
  <modelVersion>4.0.0</modelVersion>
  <parent>
		<groupId>org.idempiere</groupId>
		<artifactId>org.idempiere.parent</artifactId>
		<version>6.2.0-SNAPSHOT</version>
		<relativePath>../../myexperiment/org.idempiere.parent/pom.xml</relativePath>
  </parent>
  <artifactId>org.amerpsoft.com.idempiere.editors-com</artifactId>
  <packaging>eclipse-plugin</packaging>
</project>
</pre>
MANIFEST.MF
<pre>
Manifest-Version: 1.0
Automatic-Module-Name: org.amerpsoft.editors
Bundle-ManifestVersion: 2
Bundle-Name: Extended Location Editor
Bundle-SymbolicName: org.amerpsoft.com.idempiere.editors-com;singleton:=true
Bundle-Version: 6.2.0.qualifier
Require-Bundle: org.adempiere.base;bundle-version="6.2.0",
 org.adempiere.ui;bundle-version="6.2.0",
 org.idempiere.zk.extra;bundle-version="6.2.0",
 org.adempiere.plugin.utils;bundle-version="6.2.0",
 org.adempiere.ui.zk;bundle-version="6.2.0",
 zcommon;bundle-version="8.6.0",
 zel;bundle-version="8.6.0",
 zhtml;bundle-version="8.6.0",
 zul;bundle-version="8.6.0",
 zk;bundle-version="8.6.0",
 zkbind;bundle-version="8.6.0",
 zkplus;bundle-version="8.6.0",
 zweb;bundle-version="8.6.0",
 org.eclipse.osgi.services;bundle-version="3.7.100"
Bundle-RequiredExecutionEnvironment: JavaSE-11
Service-Component: OSGI-INF/ModelFactory.xml,OSGI-INF/EditorFactory.xml,OSGI-INF/DisplayTypeFactory.xml,OSGI-INF/EventFactory.xml
Import-Package: org.osgi.service.event,
 org.zkoss.bind,
 org.zkoss.zul.impl
Bundle-Vendor: Amerpsoft
Bundle-ActivationPolicy: lazy
Bundle-ClassPath: .
</pre>
<pre>
Tips:
* Do not put Group ID on pom.xml
* Check parent relative path and version 6.2.0-SNAPSHOT on pom.xml
* Packaging must be "eclipse-plugin" on pom.xml
* Artifact ID must be the same (correct sintax) on pom.xml and MANIFEST.MF, because eclipse will not detect differences. 
</pre>

### 4.3 Fragment project: org.amerpsoft.com.idempiere.themes-com.
<pre>
A sample fragment plugin project related with iDempiere looks. 
You can see more information on:
Themes Amerpsoft
https://wiki.idempiere.org/en/Plugin:_Themes_Amerpsoft
</pre>
pom.xml
<pre>
<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0" 
  xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" 
  xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">
  <modelVersion>4.0.0</modelVersion>
  <parent>
		<groupId>org.idempiere</groupId>
		<artifactId>org.idempiere.parent</artifactId>
		<version>6.2.0-SNAPSHOT</version>
		<relativePath>../../myexperiment/org.idempiere.parent/pom.xml</relativePath>
  </parent>
  <artifactId>org.amerpsoft.com.idempiere.themes-com</artifactId>
  <packaging>eclipse-plugin</packaging>
<!--   <groupId>org.amerpsoft.com.idempiere</groupId> -->
</project>
</pre>
build.properties
<pre>
source.. = src/
output.. = bin/
bin.includes = META-INF/,\
               .,\
               WEB-INF/,\
               theme/
src.includes = theme/
</pre>
MANIFEST.MF
<pre>
Manifest-Version: 1.0
Bundle-ManifestVersion: 2
Bundle-Name: Idempiere Themes Community version
Bundle-SymbolicName: org.amerpsoft.com.idempiere.themes-com
Bundle-Version: 6.2.0.qualifier
Bundle-ClassPath: theme/,
  .
Fragment-Host: org.adempiere.ui.zk;bundle-version="6.2.0"
Bundle-RequiredExecutionEnvironment: JavaSE-1.8
Jetty-WarFragmentFolderPath: /
Bundle-Vendor: Amerpsoft
</pre>
<pre>
Tips:
* Do not put Group ID on pom.xml
* Check parent relative path and version 6.2.0-SNAPSHOT on pom.xml
* Packaging must be "eclipse-plugin" on pom.xml
* Artifact ID must be the same (correct sintax) on pom.xml and MANIFEST.MF, because eclipse will not detect differences. 
</pre>


### 4.4 P2.site project: org.amerpsoft.com.idempiere.p2.site.
<pre>
This project must be added to plugin group.
</pre>
pom.xml
<pre>
<project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" 
  xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">
  <modelVersion>4.0.0</modelVersion>
  <artifactId>org.amerpsoft.com.idempiere.p2.site</artifactId>
  <parent>
		<groupId>org.idempiere</groupId>
		<artifactId>org.idempiere.parent</artifactId>
		<version>6.2.0-SNAPSHOT</version>
		<relativePath>../../myexperiment/org.idempiere.parent/pom.xml</relativePath>
  </parent>
  <packaging>eclipse-repository</packaging>
  <build>
		<plugins>
			<plugin>
				<groupId>org.eclipse.tycho</groupId>
				<artifactId>tycho-p2-repository-plugin</artifactId>
				<executions>
					<execution>
						<!-- install the product using the p2 director -->
						<id>build-site-p2</id>
						<goals>
							<goal>assemble-repository</goal>
						</goals>
					</execution>
				</executions>
				<configuration>
					<includeAllDependencies>false</includeAllDependencies>
					<!-- https://bugs.eclipse.org/bugs/show_bug.cgi?id=512396 -->
					<xzCompress>false</xzCompress>
				</configuration>
			</plugin>
		</plugins>
  </build>
</project>
</pre>
category.xml
<pre>
<?xml version="1.0" encoding="UTF-8"?>
<site>
    <feature 
    	url="features/org.amerpsoft.com.idempiere.feature_6.2.0.qualifier.jar" 
    	id="org.amerpsoft.com.idempiere.feature" version="6.2.0.qualifier">
	    <category name="org.amerpsoft.idempiere"/>
    </feature>
</site>
</pre>
<pre>
Tips:
* Do not put Group ID on pom.xml
* Check parent relative path and version 6.2.0-SNAPSHOT on pom.xml
* Packaging must be "eclipse-repository" on pom.xml
* Feature project id must be the same (correct sintax) on pom.xml and category.xml, because eclipse will not detect differences.
    id="org.amerpsoft.com.idempiere.feature" 
</pre>


### 4.5 P2.targetplatform project: org.amerpsoft.com.idempiere.p2.targetplatform.
<pre>
This project must be added to plugin group.
</pre>
pom.xml
<pre>
<project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">
  <modelVersion>4.0.0</modelVersion>
  <parent>
		<groupId>org.idempiere</groupId>
		<artifactId>org.idempiere.parent</artifactId>
		<version>6.2.0-SNAPSHOT</version>
		<relativePath>../../myexperiment/org.idempiere.parent/pom.xml</relativePath>
  </parent>
  <artifactId>org.amerpsoft.com.idempiere.p2.targetplatform</artifactId>
  <packaging>eclipse-target-definition</packaging>
<!--   <groupId>org.amerpsoft.com.idempiere</groupId> -->
</project>
</pre>
org.amerpsoft.com.idempiere.p2.targetplatform.target
<pre>
<?xml version="1.0" encoding="UTF-8" standalone="no"?><?pde version="3.8"?><target name="idempiere-6.2" sequenceNumber="91">
<locations>
	<location includeAllPlatforms="false" includeConfigurePhase="true" includeMode="slicer" includeSource="true" type="InstallableUnit">
		<unit id="org.adempiere.base.feature.feature.group"/>
		<unit id="org.adempiere.bundles.external.feature.feature.group"/>
		<unit id="org.adempiere.payment.processor.feature.feature.group"/>
		<unit id="org.adempiere.pipo.feature.feature.group"/>
		<unit id="org.adempiere.replication.feature.feature.group"/>
		<unit id="org.adempiere.replication.server.feature.feature.group"/>
		<unit id="org.adempiere.report.jasper.feature.feature.group"/>
		<unit id="org.adempiere.server.feature.feature.group"/>
		<unit id="org.adempiere.target.platform.feature.feature.group"/>
		<unit id="org.adempiere.ui.zk.feature.feature.group"/>
		<unit id="org.adempiere.webstore.feature.feature.group"/>
		<unit id="org.compiere.db.provider.feature.feature.group"/>
		<unit id="org.eclipse.ecf.core.feature.feature.group"/>
		<unit id="org.eclipse.ecf.core.ssl.feature.feature.group"/>
		<unit id="org.eclipse.ecf.filetransfer.feature.feature.group"/>
		<unit id="org.eclipse.ecf.filetransfer.httpclient4.feature.feature.group"/>
		<unit id="org.eclipse.ecf.filetransfer.httpclient4.ssl.feature.feature.group"/>
		<unit id="org.eclipse.ecf.filetransfer.ssl.feature.feature.group"/>
		<unit id="org.eclipse.equinox.executable.feature.group"/>
		<unit id="org.eclipse.equinox.server.core.feature.group"/>
		<unit id="org.eclipse.equinox.server.p2.feature.group"/>
		<unit id="org.idempiere.eclipse.platform.feature.feature.group"/>
		<unit id="org.idempiere.equinox.p2.director.feature.feature.group"/>
		<unit id="org.idempiere.felix.webconsole.feature.feature.group"/>
		<unit id="org.idempiere.fitnesse.feature.feature.group"/>
		<unit id="org.idempiere.hazelcast.service.feature.feature.group"/>
		<unit id="org.idempiere.zk.feature.feature.group"/>
		<repository location="file:///Volumes/Datos/Adempiere/iDempiere6.2srcmac/myexperiment/org.idempiere.p2/target/repository"/>
	</location>
</locations>
<targetJRE path="org.eclipse.jdt.launching.JRE_CONTAINER/org.eclipse.jdt.internal.debug.ui.launcher.StandardVMType/JavaSE-11"/>
</target>
</pre>
<pre>
Tips:
* Do not put Group ID on pom.xml
* Check parent relative path and version 6.2.0-SNAPSHOT on pom.xml
* Packaging must be "eclipse-target-definition" on pom.xml
* Verify repository location. It should be the directory of your source code "org.idempiere.p2" project.
</pre>
### 4.6 Main plugin project.
In this example main project, that holds all plugins is located on:
    Amerpsoft-iDempiere-community/
pom.xml
<pre>
<project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">
  <modelVersion>4.0.0</modelVersion>
  <artifactId>amerpsoft-idempiere-community</artifactId>
  <version>6.2.0-SNAPSHOT</version>
  <packaging>pom</packaging>
  <modules>
   	<module>org.amerpsoft.com.idempiere.feature</module> 	
  	<module>org.amerpsoft.com.idempiere.editors-com</module>
  	<module>org.amerpsoft.com.idempiere.p2.site</module>
  	<module>org.amerpsoft.com.idempiere.p2.targetplatform</module>
  	<module>org.amerpsoft.com.idempiere.themes-com</module>
  </modules>
  <groupId>org.idempiere</groupId>
</project>
</pre>
<pre>
Tips:
* Check version 6.2.0-SNAPSHOT on pom.xml
* Packaging must be "pom" on pom.xml
* Verify correct sintax on modules. In this case modules can be added using Overview Tam (Modules sub-tab) and eclipse must be able to find them if they are full completed correctly.
</pre>
## 5. Maven generate plugins.
<pre>
Once project are completely clean and tested, they can be generated using mvn command.
On main plugins directory:
</pre>
mvn verify -Didempiere.target=org.amerpsoft.com.idempiere.p2.targetplatform -X
<pre>
Jar files are generated on:
org.amerpsoft.com.idempiere.p2.site/target/repository/plugins
    for plugin projects
org.amerpsoft.com.idempiere.p2.site/target/repository/plugins
    for feature projects
</pre>
