



#import "NSArray+Log.h"

@implementation NSArray (Log)

- (NSString *)descriptionWithLocale:(id)locale
{
    NSMutableString *muStr = [NSMutableString stringWithString:@"(\n"];
    
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [muStr appendFormat:@"\t%@,\n", obj];
    }];
    
    [muStr appendString:@")"];
    
    return muStr;
}

@end

@implementation NSDictionary (Log)

- (NSString *)descriptionWithLocale:(id)locale
{
    NSMutableString *muStr = [NSMutableString stringWithString:@"{\n"];
    
    [self enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        [muStr appendFormat:@"\t%@ = %@;\n", key, obj];
    }];
    
    [muStr appendString:@"}\n"];
    
    return muStr;
}

/**
 
 NSMutableString *muStr = [NSMutableString stringWithString:@"{\n"];
 
 for (id obj in self.allKeys) {
 
 [muStr appendFormat:@"\t\t\"%@\" = %@", obj, self[obj]];
 }
 [muStr appendString:@"\n\t}\n"];
 
 return muStr;
 }
 */

@end