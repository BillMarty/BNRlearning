#if DEBUG
#define MyLog(args...)    NSLog( @"%@", [NSString stringWithFormat: args])
#define LogMethod() NSLog(@"%s (line %d) %@", __PRETTY_FUNCTION__, __LINE__, [NSThread isMainThread] ? @"" : [NSThread currentThread])

#else
// DEBUG not defined:

#define MyLog(args...)    // do nothing.
#define LogMethod()

#endif
