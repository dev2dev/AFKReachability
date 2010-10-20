AFKReachability
===============

This class provides a much-simplified approach to determining the availability of networking on an iOS device. There are two ways of using it: one-time and continuous monitoring.


One-time Use
------------

* Add the SystemConfiguration framework to your project
* Add the AFKReachability.m and AFKReachability.h files to your project
* Import AFKReachability.h
* call +testReachabilityOfDestination:notifyTarget:selector:

The destinationUrl parameter is a string that provides an address against which network availability should be checked (that is, you will be checking whether a *specific* address is reachable and how, rather than simply checking if networking is enabled).

AFKReachability will invoke the target/selector provided, which should take a single parameter of type AFKReachabilityResult. Depending on the value of the result, you can test whether there is no networking, or whether your destination can be reached either via Wi-Fi or 3G (if you don't care, you can simply test whether the result value is non-zero).


Continuous monitoring
----------------------

* Add the SystemConfiguration framework to your project
* Add the AFKReachability.m and AFKReachability.h files to your project
* Import AFKReachability.h
* Instantiate AFKReadability with the - initWithTarget:selector:destination:;
* call the -start method

From this point on, you will be notified of any changes in networking configuration. If your app is running on a version of iOS that supports multi-tasking, the notifications work across foreground/background cycles, so there is no need to reinstantiate them upon entering foreground state.


Requirements
------------

Should work on iOS 3.0 and higher


Sample project
--------------

The sample project displays a single label with the current networking status (e.g.: 3G, Wi-Fi or none). It should work on devices running iOS 3.2 or higher.