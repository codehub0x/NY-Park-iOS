//
//  MyTextInputControllerBase.m
//  iPark
//
//  Created by King on 2019/12/5.
//  Copyright © 2019 King. All rights reserved.
//

#import "CustomTextInputControllerOutlined.h"
#import "MDCTextInputControllerOutlined.h"
#import "MaterialMath.h"
#import "MDCTextInput.h"

static const CGFloat CustomTextInputOutlinedTextFieldFullPadding = 8;
static const CGFloat CustomTextInputOutlinedTextFieldNormalPlaceholderPadding = 10;

@interface CustomTextInputControllerOutlined ()

@end

@implementation CustomTextInputControllerOutlined

- (instancetype)initWithTextInput:(UIView<MDCTextInput> *)input {
  self = [super initWithTextInput:input];
  return self;
}

- (UIEdgeInsets)textInsets:(UIEdgeInsets)defaultInsets
    withSizeThatFitsWidthHint:(CGFloat)widthHint {
  defaultInsets.left = CustomTextInputOutlinedTextFieldFullPadding;
  defaultInsets.right = CustomTextInputOutlinedTextFieldFullPadding;
  UIEdgeInsets textInsets = [super textInsets:defaultInsets withSizeThatFitsWidthHint:widthHint];
  CGFloat textVerticalOffset = self.textInput.placeholderLabel.font.lineHeight * (CGFloat)0.5;

  CGFloat scale = UIScreen.mainScreen.scale;
  CGFloat placeholderEstimatedHeight =
      MDCCeil(self.textInput.placeholderLabel.font.lineHeight * scale) / scale;
  textInsets.top = [self borderHeight] - CustomTextInputOutlinedTextFieldFullPadding -
                   placeholderEstimatedHeight + textVerticalOffset;

  return textInsets;
}

- (CGFloat)borderHeight {
  CGFloat scale = UIScreen.mainScreen.scale;
  CGFloat placeholderEstimatedHeight =
      MDCCeil(self.textInput.placeholderLabel.font.lineHeight * scale) / scale;
  return CustomTextInputOutlinedTextFieldNormalPlaceholderPadding + placeholderEstimatedHeight +
         CustomTextInputOutlinedTextFieldNormalPlaceholderPadding;
}

@end
