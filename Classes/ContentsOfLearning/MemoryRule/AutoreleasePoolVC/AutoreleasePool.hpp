//
//  AutoreleasePool.hpp
//  LearnObjectiveC
//
//  Created by Apple on 2019/5/15.
//  Copyright © 2019 橘子. All rights reserved.
//

#ifndef AutoreleasePool_hpp
#define AutoreleasePool_hpp

#include <stdio.h>

extern  void * objc_autoreleasePoolPush(void);

extern  void objc_autoreleasePoolPop(void *);

struct __AtAutoreleasePool {
    __AtAutoreleasePool() {atautoreleasepoolobj = objc_autoreleasePoolPush();}
    ~__AtAutoreleasePool() {objc_autoreleasePoolPop(atautoreleasepoolobj);}
    void * atautoreleasepoolobj;
};

#endif /* AutoreleasePool_hpp */
