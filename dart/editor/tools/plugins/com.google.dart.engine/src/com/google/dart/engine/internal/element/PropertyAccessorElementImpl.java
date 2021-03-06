/*
 * Copyright (c) 2012, the Dart project authors.
 * 
 * Licensed under the Eclipse Public License v1.0 (the "License"); you may not use this file except
 * in compliance with the License. You may obtain a copy of the License at
 * 
 * http://www.eclipse.org/legal/epl-v10.html
 * 
 * Unless required by applicable law or agreed to in writing, software distributed under the License
 * is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express
 * or implied. See the License for the specific language governing permissions and limitations under
 * the License.
 */
package com.google.dart.engine.internal.element;

import com.google.dart.engine.ast.Identifier;
import com.google.dart.engine.element.ElementKind;
import com.google.dart.engine.element.ElementVisitor;
import com.google.dart.engine.element.PropertyAccessorElement;
import com.google.dart.engine.element.PropertyInducingElement;

/**
 * Instances of the class {@code PropertyAccessorElementImpl} implement a
 * {@code PropertyAccessorElement}.
 * 
 * @coverage dart.engine.element
 */
public class PropertyAccessorElementImpl extends ExecutableElementImpl implements
    PropertyAccessorElement {
  /**
   * The variable associated with this accessor.
   */
  private PropertyInducingElement variable;

  /**
   * An empty array of property accessor elements.
   */
  public static final PropertyAccessorElement[] EMPTY_ARRAY = new PropertyAccessorElement[0];

  /**
   * Initialize a newly created property accessor element to have the given name.
   * 
   * @param name the name of this element
   */
  public PropertyAccessorElementImpl(Identifier name) {
    super(name);
  }

  /**
   * Initialize a newly created synthetic property accessor element to be associated with the given
   * variable.
   * 
   * @param variable the variable with which this access is associated
   */
  public PropertyAccessorElementImpl(PropertyInducingElementImpl variable) {
    super(variable.getName(), -1);
    this.variable = variable;
    setSynthetic(true);
  }

  @Override
  public <R> R accept(ElementVisitor<R> visitor) {
    return visitor.visitPropertyAccessorElement(this);
  }

  @Override
  public boolean equals(Object object) {
    return super.equals(object) && isGetter() == ((PropertyAccessorElement) object).isGetter();
  }

  @Override
  public ElementKind getKind() {
    if (isGetter()) {
      return ElementKind.GETTER;
    }
    return ElementKind.SETTER;
  }

  @Override
  public PropertyInducingElement getVariable() {
    return variable;
  }

  @Override
  public boolean isGetter() {
    return hasModifier(Modifier.GETTER);
  }

  @Override
  public boolean isSetter() {
    return hasModifier(Modifier.SETTER);
  }

  @Override
  public boolean isStatic() {
    return getVariable().isStatic();
  }

  /**
   * Set whether this accessor is a getter to correspond to the given value.
   * 
   * @param isGetter {@code true} if the accessor is a getter
   */
  public void setGetter(boolean isGetter) {
    setModifier(Modifier.GETTER, isGetter);
  }

  /**
   * Set whether this accessor is a setter to correspond to the given value.
   * 
   * @param isSetter {@code true} if the accessor is a setter
   */
  public void setSetter(boolean isSetter) {
    setModifier(Modifier.SETTER, isSetter);
  }

  /**
   * Set the variable associated with this accessor to the given variable.
   * 
   * @param variable the variable associated with this accessor
   */
  public void setVariable(PropertyInducingElement variable) {
    this.variable = variable;
  }

  @Override
  protected void appendTo(StringBuilder builder) {
    builder.append(isGetter() ? "get " : "set ");
    builder.append(getVariable().getName());
    super.appendTo(builder);
  }
}
