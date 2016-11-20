//
//  TableViewSectionsObject.m
//  _BusinessApp_
//
//  Created by Gytenis Mikulėnas on 1/14/16.
//  Copyright (c) 2015 Gytenis Mikulėnas
//  https://github.com/GitTennis/SuccessFramework
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE. All rights reserved.
//

#import "TableViewSectionsObject.h"

@implementation TableViewSectionsObject

@synthesize list = _list;

#pragma mark - Public -

- (instancetype)initWithList:(NSArray *)list sortByProperties:(NSArray <TableViewSortRuleObject> *)sortByProperties groupByPropertyName:(NSString *)groupPropertyName shouldGroupByFirstLetter:(BOOL)shouldGroupByFirstLetter {
    
    self = [super init];
    if (self) {
        
        // Sort grouped items
        NSArray *sortedArray = [self performSortOfItems:list sortByProperties:sortByProperties];
        
        // Group companies
        _list = [self groupItemsFromList:sortedArray groupByProperty:groupPropertyName shouldGroupByFirstLetter:shouldGroupByFirstLetter];
    }
    return self;
}

#pragma mark - Private -

- (NSArray *)performSortOfItems:(NSArray *)unsortedItems sortByProperties:(NSArray <TableViewSortRuleObject> *)sortByProperties {
    
    NSMutableArray *sortDescriptors = [[NSMutableArray alloc] initWithCapacity:sortByProperties.count];
    NSSortDescriptor *sortDescriptor = nil;
    
    for (id<TableViewSortRuleObject> sortRule in sortByProperties) {
        
        sortDescriptor = [[NSSortDescriptor alloc] initWithKey:sortRule.propertyName
                                    ascending:sortRule.isAscending];
        [sortDescriptors addObject:sortDescriptor];
    }
    
    NSArray *sortedItems = [unsortedItems sortedArrayUsingDescriptors:sortDescriptors];
    
    return (NSArray *)sortedItems;
}

- (NSArray <TableViewSectionObject> *)groupItemsFromList:(NSArray *)list groupByProperty:(NSString *)groupPropertyName shouldGroupByFirstLetter:(BOOL)shouldGroupByFirstLetter {
    
    NSMutableArray *groupedSections = nil;
    
    for (NSObject *item in list) {
        
// Used from http://stackoverflow.com/a/10797893/597292
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        // Extract section title
        NSString *sectionTitle = [item performSelector:NSSelectorFromString(groupPropertyName)];
#pragma clang diagnostic pop
        
        if (shouldGroupByFirstLetter) {
            
            sectionTitle = [sectionTitle substringToIndex:1];
            sectionTitle = [sectionTitle uppercaseString];
        }
        
        // Lazy instantiation
        if (!groupedSections) {
            
            groupedSections = [[NSMutableArray alloc] init];
        }
        
        // Check if section was created before
        TableViewSectionObject *alreadyAddedSection = [self performFilterSectionByTitle:sectionTitle groupedSections:(NSArray <TableViewSectionObject> *)groupedSections];
        
        // If section was already added
        if (alreadyAddedSection) {
            
            NSMutableArray *sectionRows = [NSMutableArray arrayWithArray:alreadyAddedSection.sectionRows];
            [sectionRows addObject:item];
            alreadyAddedSection.sectionRows = sectionRows;
            
        // Else create a new section section
        } else {
            
            TableViewSectionObject *section = [[TableViewSectionObject alloc] init];
            section.sectionTitle = sectionTitle;
            NSMutableArray *sectionRows = [[NSMutableArray alloc] init];
            [sectionRows addObject:item];
            section.sectionRows = sectionRows;
            
            [groupedSections addObject:section];
        }
    }
    
    return (NSArray <TableViewSectionObject> *)groupedSections;
}

- (TableViewSectionObject *)performFilterSectionByTitle:(NSString *)sectionTitle groupedSections:(NSArray <TableViewSectionObject> *)groupedSections {
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%K==%@", kTableViewSectionSectionTitleProperty, sectionTitle];
    NSArray *resultList = [groupedSections filteredArrayUsingPredicate:predicate];
    
    TableViewSectionObject *section = [resultList firstObject];
    
    return section;
}

@end
