// This code was auto-generated, is not intended to be edited, and is subject to
// significant change. Please see the README file for more information.

library engine.ast;

import 'dart:collection';
import 'java_core.dart';
import 'java_engine.dart';
import 'error.dart';
import 'scanner.dart';
import 'package:analyzer-experimental/src/generated/utilities_dart.dart';
import 'element.dart' hide Annotation;

/**
 * The abstract class {@code ASTNode} defines the behavior common to all nodes in the AST structure
 * for a Dart program.
 */
abstract class ASTNode {
  /**
   * The parent of the node, or {@code null} if the node is the root of an AST structure.
   */
  ASTNode _parent;
  /**
   * A comparator that can be used to sort AST nodes in lexical order. In other words,{@code compare} will return a negative value if the offset of the first node is less than the
   * offset of the second node, zero (0) if the nodes have the same offset, and a positive value if
   * if the offset of the first node is greater than the offset of the second node.
   */
  static Comparator<ASTNode> LEXICAL_ORDER = (ASTNode first, ASTNode second) => second.offset - first.offset;
  /**
   * Use the given visitor to visit this node.
   * @param visitor the visitor that will visit this node
   * @return the value returned by the visitor as a result of visiting this node
   */
  accept(ASTVisitor visitor);
  /**
   * Return the first token included in this node's source range.
   * @return the first token included in this node's source range
   */
  Token get beginToken;
  /**
   * Return the offset of the character immediately following the last character of this node's
   * source range. This is equivalent to {@code node.getOffset() + node.getLength()}. For a
   * compilation unit this will be equal to the length of the unit's source. For synthetic nodes
   * this will be equivalent to the node's offset (because the length is zero (0) by definition).
   * @return the offset of the character just past the node's source range
   */
  int get end => offset + length;
  /**
   * Return the last token included in this node's source range.
   * @return the last token included in this node's source range
   */
  Token get endToken;
  /**
   * Return the number of characters in the node's source range.
   * @return the number of characters in the node's source range
   */
  int get length {
    Token beginToken2 = beginToken;
    Token endToken3 = endToken;
    if (beginToken2 == null || endToken3 == null) {
      return -1;
    }
    return endToken3.offset + endToken3.length - beginToken2.offset;
  }
  /**
   * Return the offset from the beginning of the file to the first character in the node's source
   * range.
   * @return the offset from the beginning of the file to the first character in the node's source
   * range
   */
  int get offset {
    Token beginToken3 = beginToken;
    if (beginToken3 == null) {
      return -1;
    }
    return beginToken.offset;
  }
  /**
   * Return this node's parent node, or {@code null} if this node is the root of an AST structure.
   * <p>
   * Note that the relationship between an AST node and its parent node may change over the lifetime
   * of a node.
   * @return the parent of this node, or {@code null} if none
   */
  ASTNode get parent => _parent;
  /**
   * Return the node at the root of this node's AST structure. Note that this method's performance
   * is linear with respect to the depth of the node in the AST structure (O(depth)).
   * @return the node at the root of this node's AST structure
   */
  ASTNode get root {
    ASTNode root = this;
    ASTNode parent3 = parent;
    while (parent3 != null) {
      root = parent3;
      parent3 = root.parent;
    }
    return root;
  }
  /**
   * Return {@code true} if this node is a synthetic node. A synthetic node is a node that was
   * introduced by the parser in order to recover from an error in the code. Synthetic nodes always
   * have a length of zero ({@code 0}).
   * @return {@code true} if this node is a synthetic node
   */
  bool isSynthetic() => false;
  /**
   * Return a textual description of this node in a form approximating valid source. The returned
   * string will not be valid source primarily in the case where the node itself is not well-formed.
   * @return the source code equivalent of this node
   */
  String toSource() {
    PrintStringWriter writer = new PrintStringWriter();
    accept(new ToSourceVisitor(writer));
    return writer.toString();
  }
  String toString() => toSource();
  /**
   * Use the given visitor to visit all of the children of this node. The children will be visited
   * in source order.
   * @param visitor the visitor that will be used to visit the children of this node
   */
  void visitChildren(ASTVisitor<Object> visitor);
  /**
   * Make this node the parent of the given child node.
   * @param child the node that will become a child of this node
   * @return the node that was made a child of this node
   */
  ASTNode becomeParentOf(ASTNode child) {
    if (child != null) {
      ASTNode node = child;
      node.parent2 = this;
    }
    return child;
  }
  /**
   * If the given child is not {@code null}, use the given visitor to visit it.
   * @param child the child to be visited
   * @param visitor the visitor that will be used to visit the child
   */
  void safelyVisitChild(ASTNode child, ASTVisitor<Object> visitor) {
    if (child != null) {
      child.accept(visitor);
    }
  }
  /**
   * Set the parent of this node to the given node.
   * @param newParent the node that is to be made the parent of this node
   */
  void set parent2(ASTNode newParent) {
    _parent = newParent;
  }
}
/**
 * The interface {@code ASTVisitor} defines the behavior of objects that can be used to visit an AST
 * structure.
 */
abstract class ASTVisitor<R> {
  R visitAdjacentStrings(AdjacentStrings node);
  R visitAnnotation(Annotation node);
  R visitArgumentDefinitionTest(ArgumentDefinitionTest node);
  R visitArgumentList(ArgumentList node);
  R visitAsExpression(AsExpression node);
  R visitAssertStatement(AssertStatement assertStatement);
  R visitAssignmentExpression(AssignmentExpression node);
  R visitBinaryExpression(BinaryExpression node);
  R visitBlock(Block node);
  R visitBlockFunctionBody(BlockFunctionBody node);
  R visitBooleanLiteral(BooleanLiteral node);
  R visitBreakStatement(BreakStatement node);
  R visitCascadeExpression(CascadeExpression node);
  R visitCatchClause(CatchClause node);
  R visitClassDeclaration(ClassDeclaration node);
  R visitClassTypeAlias(ClassTypeAlias node);
  R visitComment(Comment node);
  R visitCommentReference(CommentReference node);
  R visitCompilationUnit(CompilationUnit node);
  R visitConditionalExpression(ConditionalExpression node);
  R visitConstructorDeclaration(ConstructorDeclaration node);
  R visitConstructorFieldInitializer(ConstructorFieldInitializer node);
  R visitConstructorName(ConstructorName node);
  R visitContinueStatement(ContinueStatement node);
  R visitDefaultFormalParameter(DefaultFormalParameter node);
  R visitDoStatement(DoStatement node);
  R visitDoubleLiteral(DoubleLiteral node);
  R visitEmptyFunctionBody(EmptyFunctionBody node);
  R visitEmptyStatement(EmptyStatement node);
  R visitExportDirective(ExportDirective node);
  R visitExpressionFunctionBody(ExpressionFunctionBody node);
  R visitExpressionStatement(ExpressionStatement node);
  R visitExtendsClause(ExtendsClause node);
  R visitFieldDeclaration(FieldDeclaration node);
  R visitFieldFormalParameter(FieldFormalParameter node);
  R visitForEachStatement(ForEachStatement node);
  R visitFormalParameterList(FormalParameterList node);
  R visitForStatement(ForStatement node);
  R visitFunctionDeclaration(FunctionDeclaration node);
  R visitFunctionDeclarationStatement(FunctionDeclarationStatement node);
  R visitFunctionExpression(FunctionExpression node);
  R visitFunctionExpressionInvocation(FunctionExpressionInvocation node);
  R visitFunctionTypeAlias(FunctionTypeAlias functionTypeAlias);
  R visitFunctionTypedFormalParameter(FunctionTypedFormalParameter node);
  R visitHideCombinator(HideCombinator node);
  R visitIfStatement(IfStatement node);
  R visitImplementsClause(ImplementsClause node);
  R visitImportDirective(ImportDirective node);
  R visitIndexExpression(IndexExpression node);
  R visitInstanceCreationExpression(InstanceCreationExpression node);
  R visitIntegerLiteral(IntegerLiteral node);
  R visitInterpolationExpression(InterpolationExpression node);
  R visitInterpolationString(InterpolationString node);
  R visitIsExpression(IsExpression node);
  R visitLabel(Label node);
  R visitLabeledStatement(LabeledStatement node);
  R visitLibraryDirective(LibraryDirective node);
  R visitLibraryIdentifier(LibraryIdentifier node);
  R visitListLiteral(ListLiteral node);
  R visitMapLiteral(MapLiteral node);
  R visitMapLiteralEntry(MapLiteralEntry node);
  R visitMethodDeclaration(MethodDeclaration node);
  R visitMethodInvocation(MethodInvocation node);
  R visitNamedExpression(NamedExpression node);
  R visitNullLiteral(NullLiteral node);
  R visitParenthesizedExpression(ParenthesizedExpression node);
  R visitPartDirective(PartDirective node);
  R visitPartOfDirective(PartOfDirective node);
  R visitPostfixExpression(PostfixExpression node);
  R visitPrefixedIdentifier(PrefixedIdentifier node);
  R visitPrefixExpression(PrefixExpression node);
  R visitPropertyAccess(PropertyAccess node);
  R visitRedirectingConstructorInvocation(RedirectingConstructorInvocation node);
  R visitReturnStatement(ReturnStatement node);
  R visitScriptTag(ScriptTag node);
  R visitShowCombinator(ShowCombinator node);
  R visitSimpleFormalParameter(SimpleFormalParameter node);
  R visitSimpleIdentifier(SimpleIdentifier node);
  R visitSimpleStringLiteral(SimpleStringLiteral node);
  R visitStringInterpolation(StringInterpolation node);
  R visitSuperConstructorInvocation(SuperConstructorInvocation node);
  R visitSuperExpression(SuperExpression node);
  R visitSwitchCase(SwitchCase node);
  R visitSwitchDefault(SwitchDefault node);
  R visitSwitchStatement(SwitchStatement node);
  R visitThisExpression(ThisExpression node);
  R visitThrowExpression(ThrowExpression node);
  R visitTopLevelVariableDeclaration(TopLevelVariableDeclaration node);
  R visitTryStatement(TryStatement node);
  R visitTypeArgumentList(TypeArgumentList node);
  R visitTypeName(TypeName node);
  R visitTypeParameter(TypeParameter node);
  R visitTypeParameterList(TypeParameterList node);
  R visitVariableDeclaration(VariableDeclaration node);
  R visitVariableDeclarationList(VariableDeclarationList node);
  R visitVariableDeclarationStatement(VariableDeclarationStatement node);
  R visitWhileStatement(WhileStatement node);
  R visitWithClause(WithClause node);
}
/**
 * Instances of the class {@code AdjacentStrings} represents two or more string literals that are
 * implicitly concatenated because of being adjacent (separated only by whitespace).
 * <p>
 * While the grammar only allows adjacent strings when all of the strings are of the same kind
 * (single line or multi-line), this class doesn't enforce that restriction.
 * <pre>
 * adjacentStrings ::={@link StringLiteral string} {@link StringLiteral string}+
 * </pre>
 */
class AdjacentStrings extends StringLiteral {
  /**
   * The strings that are implicitly concatenated.
   */
  NodeList<StringLiteral> _strings;
  /**
   * Initialize a newly created list of adjacent strings.
   * @param strings the strings that are implicitly concatenated
   */
  AdjacentStrings(List<StringLiteral> strings) {
    this._strings = new NodeList<StringLiteral>(this);
    this._strings.addAll(strings);
  }
  accept(ASTVisitor visitor) => visitor.visitAdjacentStrings(this);
  Token get beginToken => _strings.beginToken;
  Token get endToken => _strings.endToken;
  /**
   * Return the strings that are implicitly concatenated.
   * @return the strings that are implicitly concatenated
   */
  NodeList<StringLiteral> get strings => _strings;
  void visitChildren(ASTVisitor<Object> visitor) {
    _strings.accept(visitor);
  }
}
/**
 * The abstract class {@code AnnotatedNode} defines the behavior of nodes that can be annotated with
 * both a comment and metadata.
 */
abstract class AnnotatedNode extends ASTNode {
  /**
   * The documentation comment associated with this node, or {@code null} if this node does not have
   * a documentation comment associated with it.
   */
  Comment _comment;
  /**
   * The annotations associated with this node.
   */
  NodeList<Annotation> _metadata;
  /**
   * Initialize a newly created node.
   * @param comment the documentation comment associated with this node
   * @param metadata the annotations associated with this node
   */
  AnnotatedNode(Comment comment, List<Annotation> metadata) {
    this._metadata = new NodeList<Annotation>(this);
    this._comment = becomeParentOf(comment);
    this._metadata.addAll(metadata);
  }
  Token get beginToken {
    if (_comment == null) {
      if (_metadata.isEmpty) {
        return firstTokenAfterCommentAndMetadata;
      } else {
        return _metadata.beginToken;
      }
    } else if (_metadata.isEmpty) {
      return _comment.beginToken;
    }
    Token commentToken = _comment.beginToken;
    Token metadataToken = _metadata.beginToken;
    if (commentToken.offset < metadataToken.offset) {
      return commentToken;
    }
    return metadataToken;
  }
  /**
   * Return the documentation comment associated with this node, or {@code null} if this node does
   * not have a documentation comment associated with it.
   * @return the documentation comment associated with this node
   */
  Comment get documentationComment => _comment;
  /**
   * Return the annotations associated with this node.
   * @return the annotations associated with this node
   */
  NodeList<Annotation> get metadata => _metadata;
  /**
   * Set the documentation comment associated with this node to the given comment
   * @param comment the documentation comment to be associated with this node
   */
  void set documentationComment(Comment comment) {
    this._comment = becomeParentOf(comment);
  }
  void visitChildren(ASTVisitor<Object> visitor) {
    if (commentIsBeforeAnnotations()) {
      safelyVisitChild(_comment, visitor);
      _metadata.accept(visitor);
    } else {
      for (ASTNode child in sortedCommentAndAnnotations) {
        child.accept(visitor);
      }
    }
  }
  /**
   * Return the first token following the comment and metadata.
   * @return the first token following the comment and metadata
   */
  Token get firstTokenAfterCommentAndMetadata;
  /**
   * Return {@code true} if the comment is lexically before any annotations.
   * @return {@code true} if the comment is lexically before any annotations
   */
  bool commentIsBeforeAnnotations() {
    if (_comment == null || _metadata.isEmpty) {
      return true;
    }
    Annotation firstAnnotation = _metadata[0];
    return _comment.offset < firstAnnotation.offset;
  }
  /**
   * Return an array containing the comment and annotations associated with this node, sorted in
   * lexical order.
   * @return the comment and annotations associated with this node in the order in which they
   * appeared in the original source
   */
  List<ASTNode> get sortedCommentAndAnnotations {
    List<ASTNode> childList = new List<ASTNode>();
    childList.add(_comment);
    childList.addAll(_metadata);
    List<ASTNode> children = new List.from(childList);
    children.sort();
    return children;
  }
}
/**
 * Instances of the class {@code Annotation} represent an annotation that can be associated with an
 * AST node.
 * <pre>
 * metadata ::=
 * annotation
 * annotation ::=
 * '@' {@link Identifier qualified} (‚Äò.‚Äô {@link SimpleIdentifier identifier})? {@link ArgumentList arguments}?
 * </pre>
 */
class Annotation extends ASTNode {
  /**
   * The at sign that introduced the annotation.
   */
  Token _atSign;
  /**
   * The name of the class defining the constructor that is being invoked or the name of the field
   * that is being referenced.
   */
  Identifier _name;
  /**
   * The period before the constructor name, or {@code null} if this annotation is not the
   * invocation of a named constructor.
   */
  Token _period;
  /**
   * The name of the constructor being invoked, or {@code null} if this annotation is not the
   * invocation of a named constructor.
   */
  SimpleIdentifier _constructorName;
  /**
   * The arguments to the constructor being invoked, or {@code null} if this annotation is not the
   * invocation of a constructor.
   */
  ArgumentList _arguments;
  /**
   * Initialize a newly created annotation.
   * @param atSign the at sign that introduced the annotation
   * @param name the name of the class defining the constructor that is being invoked or the name of
   * the field that is being referenced
   * @param period the period before the constructor name, or {@code null} if this annotation is not
   * the invocation of a named constructor
   * @param constructorName the name of the constructor being invoked, or {@code null} if this
   * annotation is not the invocation of a named constructor
   * @param arguments the arguments to the constructor being invoked, or {@code null} if this
   * annotation is not the invocation of a constructor
   */
  Annotation(Token atSign, Identifier name, Token period, SimpleIdentifier constructorName, ArgumentList arguments) {
    this._atSign = atSign;
    this._name = becomeParentOf(name);
    this._period = period;
    this._constructorName = becomeParentOf(constructorName);
    this._arguments = becomeParentOf(arguments);
  }
  accept(ASTVisitor visitor) => visitor.visitAnnotation(this);
  /**
   * Return the arguments to the constructor being invoked, or {@code null} if this annotation is
   * not the invocation of a constructor.
   * @return the arguments to the constructor being invoked
   */
  ArgumentList get arguments => _arguments;
  /**
   * Return the at sign that introduced the annotation.
   * @return the at sign that introduced the annotation
   */
  Token get atSign => _atSign;
  Token get beginToken => _atSign;
  /**
   * Return the name of the constructor being invoked, or {@code null} if this annotation is not the
   * invocation of a named constructor.
   * @return the name of the constructor being invoked
   */
  SimpleIdentifier get constructorName => _constructorName;
  Token get endToken {
    if (_arguments != null) {
      return _arguments.endToken;
    } else if (_constructorName != null) {
      return _constructorName.endToken;
    }
    return _name.endToken;
  }
  /**
   * Return the name of the class defining the constructor that is being invoked or the name of the
   * field that is being referenced.
   * @return the name of the constructor being invoked or the name of the field being referenced
   */
  Identifier get name => _name;
  /**
   * Return the period before the constructor name, or {@code null} if this annotation is not the
   * invocation of a named constructor.
   * @return the period before the constructor name
   */
  Token get period => _period;
  /**
   * Set the arguments to the constructor being invoked to the given arguments.
   * @param arguments the arguments to the constructor being invoked
   */
  void set arguments2(ArgumentList arguments) {
    this._arguments = becomeParentOf(arguments);
  }
  /**
   * Set the at sign that introduced the annotation to the given token.
   * @param atSign the at sign that introduced the annotation
   */
  void set atSign2(Token atSign) {
    this._atSign = atSign;
  }
  /**
   * Set the name of the constructor being invoked to the given name.
   * @param constructorName the name of the constructor being invoked
   */
  void set constructorName2(SimpleIdentifier constructorName) {
    this._constructorName = becomeParentOf(constructorName);
  }
  /**
   * Set the name of the class defining the constructor that is being invoked or the name of the
   * field that is being referenced to the given name.
   * @param name the name of the constructor being invoked or the name of the field being referenced
   */
  void set name2(Identifier name) {
    this._name = becomeParentOf(name);
  }
  /**
   * Set the period before the constructor name to the given token.
   * @param period the period before the constructor name
   */
  void set period2(Token period) {
    this._period = period;
  }
  void visitChildren(ASTVisitor<Object> visitor) {
    safelyVisitChild(_name, visitor);
    safelyVisitChild(_constructorName, visitor);
    safelyVisitChild(_arguments, visitor);
  }
}
/**
 * Instances of the class {@code ArgumentDefinitionTest} represent an argument definition test.
 * <pre>
 * argumentDefinitionTest ::=
 * '?' {@link SimpleIdentifier identifier}</pre>
 */
class ArgumentDefinitionTest extends Expression {
  /**
   * The token representing the question mark.
   */
  Token _question;
  /**
   * The identifier representing the argument being tested.
   */
  SimpleIdentifier _identifier;
  /**
   * Initialize a newly created argument definition test.
   * @param question the token representing the question mark
   * @param identifier the identifier representing the argument being tested
   */
  ArgumentDefinitionTest(Token question, SimpleIdentifier identifier) {
    this._question = question;
    this._identifier = becomeParentOf(identifier);
  }
  accept(ASTVisitor visitor) => visitor.visitArgumentDefinitionTest(this);
  Token get beginToken => _question;
  Token get endToken => _identifier.endToken;
  /**
   * Return the identifier representing the argument being tested.
   * @return the identifier representing the argument being tested
   */
  SimpleIdentifier get identifier => _identifier;
  /**
   * Return the token representing the question mark.
   * @return the token representing the question mark
   */
  Token get question => _question;
  /**
   * Set the identifier representing the argument being tested to the given identifier.
   * @param identifier the identifier representing the argument being tested
   */
  void set identifier2(SimpleIdentifier identifier) {
    this._identifier = becomeParentOf(identifier);
  }
  /**
   * Set the token representing the question mark to the given token.
   * @param question the token representing the question mark
   */
  void set question2(Token question) {
    this._question = question;
  }
  void visitChildren(ASTVisitor<Object> visitor) {
    safelyVisitChild(_identifier, visitor);
  }
}
/**
 * Instances of the class {@code ArgumentList} represent a list of arguments in the invocation of a
 * executable element: a function, method, or constructor.
 * <pre>
 * argumentList ::=
 * '(' arguments? ')'
 * arguments ::={@link NamedExpression namedArgument} (',' {@link NamedExpression namedArgument})
 * | {@link Expression expressionList} (',' {@link NamedExpression namedArgument})
 * </pre>
 */
class ArgumentList extends ASTNode {
  /**
   * The left parenthesis.
   */
  Token _leftParenthesis;
  /**
   * The expressions producing the values of the arguments.
   */
  NodeList<Expression> _arguments;
  /**
   * The right parenthesis.
   */
  Token _rightParenthesis;
  /**
   * Initialize a newly created list of arguments.
   * @param leftParenthesis the left parenthesis
   * @param arguments the expressions producing the values of the arguments
   * @param rightParenthesis the right parenthesis
   */
  ArgumentList(Token leftParenthesis, List<Expression> arguments, Token rightParenthesis) {
    this._arguments = new NodeList<Expression>(this);
    this._leftParenthesis = leftParenthesis;
    this._arguments.addAll(arguments);
    this._rightParenthesis = rightParenthesis;
  }
  accept(ASTVisitor visitor) => visitor.visitArgumentList(this);
  /**
   * Return the expressions producing the values of the arguments. Although the language requires
   * that positional arguments appear before named arguments, this class allows them to be
   * intermixed.
   * @return the expressions producing the values of the arguments
   */
  NodeList<Expression> get arguments => _arguments;
  Token get beginToken => _leftParenthesis;
  Token get endToken => _rightParenthesis;
  /**
   * Return the left parenthesis.
   * @return the left parenthesis
   */
  Token get leftParenthesis => _leftParenthesis;
  /**
   * Return the right parenthesis.
   * @return the right parenthesis
   */
  Token get rightParenthesis => _rightParenthesis;
  /**
   * Set the left parenthesis to the given token.
   * @param parenthesis the left parenthesis
   */
  void set leftParenthesis2(Token parenthesis) {
    _leftParenthesis = parenthesis;
  }
  /**
   * Set the right parenthesis to the given token.
   * @param parenthesis the right parenthesis
   */
  void set rightParenthesis2(Token parenthesis) {
    _rightParenthesis = parenthesis;
  }
  void visitChildren(ASTVisitor<Object> visitor) {
    _arguments.accept(visitor);
  }
}
/**
 * Instances of the class {@code AsExpression} represent an 'as' expression.
 * <pre>
 * asExpression ::={@link Expression expression} 'as' {@link TypeName type}</pre>
 */
class AsExpression extends Expression {
  /**
   * The expression used to compute the value being cast.
   */
  Expression _expression;
  /**
   * The as operator.
   */
  Token _asOperator;
  /**
   * The name of the type being cast to.
   */
  TypeName _type;
  /**
   * Initialize a newly created as expression.
   * @param expression the expression used to compute the value being cast
   * @param isOperator the is operator
   * @param type the name of the type being cast to
   */
  AsExpression(Expression expression, Token isOperator, TypeName type) {
    this._expression = becomeParentOf(expression);
    this._asOperator = isOperator;
    this._type = becomeParentOf(type);
  }
  accept(ASTVisitor visitor) => visitor.visitAsExpression(this);
  /**
   * Return the is operator being applied.
   * @return the is operator being applied
   */
  Token get asOperator => _asOperator;
  Token get beginToken => _expression.beginToken;
  Token get endToken => _type.endToken;
  /**
   * Return the expression used to compute the value being cast.
   * @return the expression used to compute the value being cast
   */
  Expression get expression => _expression;
  /**
   * Return the name of the type being cast to.
   * @return the name of the type being cast to
   */
  TypeName get type => _type;
  /**
   * Set the is operator being applied to the given operator.
   * @param asOperator the is operator being applied
   */
  void set asOperator2(Token asOperator) {
    this._asOperator = asOperator;
  }
  /**
   * Set the expression used to compute the value being cast to the given expression.
   * @param expression the expression used to compute the value being cast
   */
  void set expression2(Expression expression) {
    this._expression = becomeParentOf(expression);
  }
  /**
   * Set the name of the type being cast to to the given name.
   * @param name the name of the type being cast to
   */
  void set type2(TypeName name) {
    this._type = becomeParentOf(name);
  }
  void visitChildren(ASTVisitor<Object> visitor) {
    safelyVisitChild(_expression, visitor);
    safelyVisitChild(_type, visitor);
  }
}
/**
 * Instances of the class {@code AssertStatement} represent an assert statement.
 * <pre>
 * assertStatement ::=
 * 'assert' '(' {@link Expression conditionalExpression} ')' ';'
 * </pre>
 */
class AssertStatement extends Statement {
  /**
   * The token representing the 'assert' keyword.
   */
  Token _keyword;
  /**
   * The left parenthesis.
   */
  Token _leftParenthesis;
  /**
   * The condition that is being asserted to be {@code true}.
   */
  Expression _condition;
  /**
   * The right parenthesis.
   */
  Token _rightParenthesis;
  /**
   * The semicolon terminating the statement.
   */
  Token _semicolon;
  /**
   * Initialize a newly created assert statement.
   * @param keyword the token representing the 'assert' keyword
   * @param leftParenthesis the left parenthesis
   * @param condition the condition that is being asserted to be {@code true}
   * @param rightParenthesis the right parenthesis
   * @param semicolon the semicolon terminating the statement
   */
  AssertStatement(Token keyword, Token leftParenthesis, Expression condition, Token rightParenthesis, Token semicolon) {
    this._keyword = keyword;
    this._leftParenthesis = leftParenthesis;
    this._condition = becomeParentOf(condition);
    this._rightParenthesis = rightParenthesis;
    this._semicolon = semicolon;
  }
  accept(ASTVisitor visitor) => visitor.visitAssertStatement(this);
  Token get beginToken => _keyword;
  /**
   * Return the condition that is being asserted to be {@code true}.
   * @return the condition that is being asserted to be {@code true}
   */
  Expression get condition => _condition;
  Token get endToken => _semicolon;
  /**
   * Return the token representing the 'assert' keyword.
   * @return the token representing the 'assert' keyword
   */
  Token get keyword => _keyword;
  /**
   * Return the left parenthesis.
   * @return the left parenthesis
   */
  Token get leftParenthesis => _leftParenthesis;
  /**
   * Return the right parenthesis.
   * @return the right parenthesis
   */
  Token get rightParenthesis => _rightParenthesis;
  /**
   * Return the semicolon terminating the statement.
   * @return the semicolon terminating the statement
   */
  Token get semicolon => _semicolon;
  /**
   * Set the condition that is being asserted to be {@code true} to the given expression.
   * @param the condition that is being asserted to be {@code true}
   */
  void set condition2(Expression condition) {
    this._condition = becomeParentOf(condition);
  }
  /**
   * Set the token representing the 'assert' keyword to the given token.
   * @param keyword the token representing the 'assert' keyword
   */
  void set keyword3(Token keyword) {
    this._keyword = keyword;
  }
  /**
   * Set the left parenthesis to the given token.
   * @param the left parenthesis
   */
  void set leftParenthesis3(Token leftParenthesis) {
    this._leftParenthesis = leftParenthesis;
  }
  /**
   * Set the right parenthesis to the given token.
   * @param rightParenthesis the right parenthesis
   */
  void set rightParenthesis3(Token rightParenthesis) {
    this._rightParenthesis = rightParenthesis;
  }
  /**
   * Set the semicolon terminating the statement to the given token.
   * @param semicolon the semicolon terminating the statement
   */
  void set semicolon2(Token semicolon) {
    this._semicolon = semicolon;
  }
  void visitChildren(ASTVisitor<Object> visitor) {
    safelyVisitChild(_condition, visitor);
  }
}
/**
 * Instances of the class {@code AssignmentExpression} represent an assignment expression.
 * <pre>
 * assignmentExpression ::={@link Expression leftHandSide} {@link Token operator} {@link Expression rightHandSide}</pre>
 */
class AssignmentExpression extends Expression {
  /**
   * The expression used to compute the left hand side.
   */
  Expression _leftHandSide;
  /**
   * The assignment operator being applied.
   */
  Token _operator;
  /**
   * The expression used to compute the right hand side.
   */
  Expression _rightHandSide;
  /**
   * The element associated with the operator, or {@code null} if the AST structure has not been
   * resolved, if the operator is not a compound operator, or if the operator could not be resolved.
   */
  MethodElement _element;
  /**
   * Initialize a newly created assignment expression.
   * @param leftHandSide the expression used to compute the left hand side
   * @param operator the assignment operator being applied
   * @param rightHandSide the expression used to compute the right hand side
   */
  AssignmentExpression(Expression leftHandSide, Token operator, Expression rightHandSide) {
    this._leftHandSide = becomeParentOf(leftHandSide);
    this._operator = operator;
    this._rightHandSide = becomeParentOf(rightHandSide);
  }
  accept(ASTVisitor visitor) => visitor.visitAssignmentExpression(this);
  Token get beginToken => _leftHandSide.beginToken;
  /**
   * Return the element associated with the operator, or {@code null} if the AST structure has not
   * been resolved, if the operator is not a compound operator, or if the operator could not be
   * resolved. One example of the latter case is an operator that is not defined for the type of the
   * left-hand operand.
   * @return the element associated with the operator
   */
  MethodElement get element => _element;
  Token get endToken => _rightHandSide.endToken;
  /**
   * Set the expression used to compute the left hand side to the given expression.
   * @return the expression used to compute the left hand side
   */
  Expression get leftHandSide => _leftHandSide;
  /**
   * Return the assignment operator being applied.
   * @return the assignment operator being applied
   */
  Token get operator => _operator;
  /**
   * Return the expression used to compute the right hand side.
   * @return the expression used to compute the right hand side
   */
  Expression get rightHandSide => _rightHandSide;
  /**
   * Set the element associated with the operator to the given element.
   * @param element the element associated with the operator
   */
  void set element2(MethodElement element) {
    this._element = element;
  }
  /**
   * Return the expression used to compute the left hand side.
   * @param expression the expression used to compute the left hand side
   */
  void set leftHandSide2(Expression expression) {
    _leftHandSide = becomeParentOf(expression);
  }
  /**
   * Set the assignment operator being applied to the given operator.
   * @param operator the assignment operator being applied
   */
  void set operator2(Token operator) {
    this._operator = operator;
  }
  /**
   * Set the expression used to compute the left hand side to the given expression.
   * @param expression the expression used to compute the left hand side
   */
  void set rightHandSide2(Expression expression) {
    _rightHandSide = becomeParentOf(expression);
  }
  void visitChildren(ASTVisitor<Object> visitor) {
    safelyVisitChild(_leftHandSide, visitor);
    safelyVisitChild(_rightHandSide, visitor);
  }
}
/**
 * Instances of the class {@code BinaryExpression} represent a binary (infix) expression.
 * <pre>
 * binaryExpression ::={@link Expression leftOperand} {@link Token operator} {@link Expression rightOperand}</pre>
 */
class BinaryExpression extends Expression {
  /**
   * The expression used to compute the left operand.
   */
  Expression _leftOperand;
  /**
   * The binary operator being applied.
   */
  Token _operator;
  /**
   * The expression used to compute the right operand.
   */
  Expression _rightOperand;
  /**
   * The element associated with the operator, or {@code null} if the AST structure has not been
   * resolved, if the operator is not user definable, or if the operator could not be resolved.
   */
  MethodElement _element;
  /**
   * Initialize a newly created binary expression.
   * @param leftOperand the expression used to compute the left operand
   * @param operator the binary operator being applied
   * @param rightOperand the expression used to compute the right operand
   */
  BinaryExpression(Expression leftOperand, Token operator, Expression rightOperand) {
    this._leftOperand = becomeParentOf(leftOperand);
    this._operator = operator;
    this._rightOperand = becomeParentOf(rightOperand);
  }
  accept(ASTVisitor visitor) => visitor.visitBinaryExpression(this);
  Token get beginToken => _leftOperand.beginToken;
  /**
   * Return the element associated with the operator, or {@code null} if the AST structure has not
   * been resolved, if the operator is not user definable, or if the operator could not be resolved.
   * One example of the latter case is an operator that is not defined for the type of the left-hand
   * operand.
   * @return the element associated with the operator
   */
  MethodElement get element => _element;
  Token get endToken => _rightOperand.endToken;
  /**
   * Return the expression used to compute the left operand.
   * @return the expression used to compute the left operand
   */
  Expression get leftOperand => _leftOperand;
  /**
   * Return the binary operator being applied.
   * @return the binary operator being applied
   */
  Token get operator => _operator;
  /**
   * Return the expression used to compute the right operand.
   * @return the expression used to compute the right operand
   */
  Expression get rightOperand => _rightOperand;
  /**
   * Set the element associated with the operator to the given element.
   * @param element the element associated with the operator
   */
  void set element3(MethodElement element) {
    this._element = element;
  }
  /**
   * Set the expression used to compute the left operand to the given expression.
   * @param expression the expression used to compute the left operand
   */
  void set leftOperand2(Expression expression) {
    _leftOperand = becomeParentOf(expression);
  }
  /**
   * Set the binary operator being applied to the given operator.
   * @return the binary operator being applied
   */
  void set operator3(Token operator) {
    this._operator = operator;
  }
  /**
   * Set the expression used to compute the right operand to the given expression.
   * @param expression the expression used to compute the right operand
   */
  void set rightOperand2(Expression expression) {
    _rightOperand = becomeParentOf(expression);
  }
  void visitChildren(ASTVisitor<Object> visitor) {
    safelyVisitChild(_leftOperand, visitor);
    safelyVisitChild(_rightOperand, visitor);
  }
}
/**
 * Instances of the class {@code Block} represent a sequence of statements.
 * <pre>
 * block ::=
 * '{' statement* '}'
 * </pre>
 */
class Block extends Statement {
  /**
   * The left curly bracket.
   */
  Token _leftBracket;
  /**
   * The statements contained in the block.
   */
  NodeList<Statement> _statements;
  /**
   * The right curly bracket.
   */
  Token _rightBracket;
  /**
   * Initialize a newly created block of code.
   * @param leftBracket the left curly bracket
   * @param statements the statements contained in the block
   * @param rightBracket the right curly bracket
   */
  Block(Token leftBracket, List<Statement> statements, Token rightBracket) {
    this._statements = new NodeList<Statement>(this);
    this._leftBracket = leftBracket;
    this._statements.addAll(statements);
    this._rightBracket = rightBracket;
  }
  accept(ASTVisitor visitor) => visitor.visitBlock(this);
  Token get beginToken => _leftBracket;
  Token get endToken => _rightBracket;
  /**
   * Return the left curly bracket.
   * @return the left curly bracket
   */
  Token get leftBracket => _leftBracket;
  /**
   * Return the right curly bracket.
   * @return the right curly bracket
   */
  Token get rightBracket => _rightBracket;
  /**
   * Return the statements contained in the block.
   * @return the statements contained in the block
   */
  NodeList<Statement> get statements => _statements;
  /**
   * Set the left curly bracket to the given token.
   * @param leftBracket the left curly bracket
   */
  void set leftBracket2(Token leftBracket) {
    this._leftBracket = leftBracket;
  }
  /**
   * Set the right curly bracket to the given token.
   * @param rightBracket the right curly bracket
   */
  void set rightBracket2(Token rightBracket) {
    this._rightBracket = rightBracket;
  }
  void visitChildren(ASTVisitor<Object> visitor) {
    _statements.accept(visitor);
  }
}
/**
 * Instances of the class {@code BlockFunctionBody} represent a function body that consists of a
 * block of statements.
 * <pre>
 * blockFunctionBody ::={@link Block block}</pre>
 */
class BlockFunctionBody extends FunctionBody {
  /**
   * The block representing the body of the function.
   */
  Block _block;
  /**
   * Initialize a newly created function body consisting of a block of statements.
   * @param block the block representing the body of the function
   */
  BlockFunctionBody(Block block) {
    this._block = becomeParentOf(block);
  }
  accept(ASTVisitor visitor) => visitor.visitBlockFunctionBody(this);
  Token get beginToken => _block.beginToken;
  /**
   * Return the block representing the body of the function.
   * @return the block representing the body of the function
   */
  Block get block => _block;
  Token get endToken => _block.endToken;
  /**
   * Set the block representing the body of the function to the given block.
   * @param block the block representing the body of the function
   */
  void set block2(Block block) {
    this._block = becomeParentOf(block);
  }
  void visitChildren(ASTVisitor<Object> visitor) {
    safelyVisitChild(_block, visitor);
  }
}
/**
 * Instances of the class {@code BooleanLiteral} represent a boolean literal expression.
 * <pre>
 * booleanLiteral ::=
 * 'false' | 'true'
 * </pre>
 */
class BooleanLiteral extends Literal {
  /**
   * The token representing the literal.
   */
  Token _literal;
  /**
   * The value of the literal.
   */
  bool _value = false;
  /**
   * Initialize a newly created boolean literal.
   * @param literal the token representing the literal
   * @param value the value of the literal
   */
  BooleanLiteral(Token literal, bool value) {
    this._literal = literal;
    this._value = value;
  }
  accept(ASTVisitor visitor) => visitor.visitBooleanLiteral(this);
  Token get beginToken => _literal;
  Token get endToken => _literal;
  /**
   * Return the token representing the literal.
   * @return the token representing the literal
   */
  Token get literal => _literal;
  /**
   * Return the value of the literal.
   * @return the value of the literal
   */
  bool get value => _value;
  bool isSynthetic() => _literal.isSynthetic();
  /**
   * Set the token representing the literal to the given token.
   * @param literal the token representing the literal
   */
  void set literal2(Token literal) {
    this._literal = literal;
  }
  /**
   * Set the value of the literal to the given value.
   * @param value the value of the literal
   */
  void set value4(bool value) {
    this._value = value;
  }
  void visitChildren(ASTVisitor<Object> visitor) {
  }
}
/**
 * Instances of the class {@code BreakStatement} represent a break statement.
 * <pre>
 * breakStatement ::=
 * 'break' {@link SimpleIdentifier label}? ';'
 * </pre>
 */
class BreakStatement extends Statement {
  /**
   * The token representing the 'break' keyword.
   */
  Token _keyword;
  /**
   * The label associated with the statement, or {@code null} if there is no label.
   */
  SimpleIdentifier _label;
  /**
   * The semicolon terminating the statement.
   */
  Token _semicolon;
  /**
   * Initialize a newly created break statement.
   * @param keyword the token representing the 'break' keyword
   * @param label the label associated with the statement
   * @param semicolon the semicolon terminating the statement
   */
  BreakStatement(Token keyword, SimpleIdentifier label, Token semicolon) {
    this._keyword = keyword;
    this._label = becomeParentOf(label);
    this._semicolon = semicolon;
  }
  accept(ASTVisitor visitor) => visitor.visitBreakStatement(this);
  Token get beginToken => _keyword;
  Token get endToken => _semicolon;
  /**
   * Return the token representing the 'break' keyword.
   * @return the token representing the 'break' keyword
   */
  Token get keyword => _keyword;
  /**
   * Return the label associated with the statement, or {@code null} if there is no label.
   * @return the label associated with the statement
   */
  SimpleIdentifier get label => _label;
  /**
   * Return the semicolon terminating the statement.
   * @return the semicolon terminating the statement
   */
  Token get semicolon => _semicolon;
  /**
   * Set the token representing the 'break' keyword to the given token.
   * @param keyword the token representing the 'break' keyword
   */
  void set keyword4(Token keyword) {
    this._keyword = keyword;
  }
  /**
   * Set the label associated with the statement to the given identifier.
   * @param identifier the label associated with the statement
   */
  void set label2(SimpleIdentifier identifier) {
    _label = becomeParentOf(identifier);
  }
  /**
   * Set the semicolon terminating the statement to the given token.
   * @param semicolon the semicolon terminating the statement
   */
  void set semicolon3(Token semicolon) {
    this._semicolon = semicolon;
  }
  void visitChildren(ASTVisitor<Object> visitor) {
    safelyVisitChild(_label, visitor);
  }
}
/**
 * Instances of the class {@code CascadeExpression} represent a sequence of cascaded expressions:
 * expressions that share a common target. There are three kinds of expressions that can be used in
 * a cascade expression: {@link IndexExpression}, {@link MethodInvocation} and{@link PropertyAccess}.
 * <pre>
 * cascadeExpression ::={@link Expression conditionalExpression} cascadeSection
 * cascadeSection ::=
 * '..'  (cascadeSelector arguments*) (assignableSelector arguments*)* (assignmentOperator expressionWithoutCascade)?
 * cascadeSelector ::=
 * '[ ' expression '] '
 * | identifier
 * </pre>
 */
class CascadeExpression extends Expression {
  /**
   * The target of the cascade sections.
   */
  Expression _target;
  /**
   * The cascade sections sharing the common target.
   */
  NodeList<Expression> _cascadeSections;
  /**
   * Initialize a newly created cascade expression.
   * @param target the target of the cascade sections
   * @param cascadeSections the cascade sections sharing the common target
   */
  CascadeExpression(Expression target, List<Expression> cascadeSections) {
    this._cascadeSections = new NodeList<Expression>(this);
    this._target = becomeParentOf(target);
    this._cascadeSections.addAll(cascadeSections);
  }
  accept(ASTVisitor visitor) => visitor.visitCascadeExpression(this);
  Token get beginToken => _target.beginToken;
  /**
   * Return the cascade sections sharing the common target.
   * @return the cascade sections sharing the common target
   */
  NodeList<Expression> get cascadeSections => _cascadeSections;
  Token get endToken => _cascadeSections.endToken;
  /**
   * Return the target of the cascade sections.
   * @return the target of the cascade sections
   */
  Expression get target => _target;
  /**
   * Set the target of the cascade sections to the given expression.
   * @param target the target of the cascade sections
   */
  void set target2(Expression target) {
    this._target = becomeParentOf(target);
  }
  void visitChildren(ASTVisitor<Object> visitor) {
    safelyVisitChild(_target, visitor);
    _cascadeSections.accept(visitor);
  }
}
/**
 * Instances of the class {@code CatchClause} represent a catch clause within a try statement.
 * <pre>
 * onPart ::=
 * catchPart {@link Block block}| 'on' type catchPart? {@link Block block}catchPart ::=
 * 'catch' '(' {@link SimpleIdentifier exceptionParameter} (',' {@link SimpleIdentifier stackTraceParameter})? ')'
 * </pre>
 */
class CatchClause extends ASTNode {
  /**
   * The token representing the 'on' keyword, or {@code null} if there is no 'on' keyword.
   */
  Token _onKeyword;
  /**
   * The type of exceptions caught by this catch clause, or {@code null} if this catch clause
   * catches every type of exception.
   */
  TypeName _exceptionType;
  /**
   * The token representing the 'catch' keyword, or {@code null} if there is no 'catch' keyword.
   */
  Token _catchKeyword;
  /**
   * The left parenthesis.
   */
  Token _leftParenthesis;
  /**
   * The parameter whose value will be the exception that was thrown.
   */
  SimpleIdentifier _exceptionParameter;
  /**
   * The comma separating the exception parameter from the stack trace parameter.
   */
  Token _comma;
  /**
   * The parameter whose value will be the stack trace associated with the exception.
   */
  SimpleIdentifier _stackTraceParameter;
  /**
   * The right parenthesis.
   */
  Token _rightParenthesis;
  /**
   * The body of the catch block.
   */
  Block _body;
  /**
   * Initialize a newly created catch clause.
   * @param onKeyword the token representing the 'on' keyword
   * @param exceptionType the type of exceptions caught by this catch clause
   * @param leftParenthesis the left parenthesis
   * @param exceptionParameter the parameter whose value will be the exception that was thrown
   * @param comma the comma separating the exception parameter from the stack trace parameter
   * @param stackTraceParameter the parameter whose value will be the stack trace associated with
   * the exception
   * @param rightParenthesis the right parenthesis
   * @param body the body of the catch block
   */
  CatchClause(Token onKeyword, TypeName exceptionType, Token catchKeyword, Token leftParenthesis, SimpleIdentifier exceptionParameter, Token comma, SimpleIdentifier stackTraceParameter, Token rightParenthesis, Block body) {
    this._onKeyword = onKeyword;
    this._exceptionType = becomeParentOf(exceptionType);
    this._catchKeyword = catchKeyword;
    this._leftParenthesis = leftParenthesis;
    this._exceptionParameter = becomeParentOf(exceptionParameter);
    this._comma = comma;
    this._stackTraceParameter = becomeParentOf(stackTraceParameter);
    this._rightParenthesis = rightParenthesis;
    this._body = becomeParentOf(body);
  }
  accept(ASTVisitor visitor) => visitor.visitCatchClause(this);
  Token get beginToken {
    if (_onKeyword != null) {
      return _onKeyword;
    }
    return _catchKeyword;
  }
  /**
   * Return the body of the catch block.
   * @return the body of the catch block
   */
  Block get body => _body;
  /**
   * Return the token representing the 'catch' keyword, or {@code null} if there is no 'catch'
   * keyword.
   * @return the token representing the 'catch' keyword
   */
  Token get catchKeyword => _catchKeyword;
  /**
   * Return the comma.
   * @return the comma
   */
  Token get comma => _comma;
  Token get endToken => _body.endToken;
  /**
   * Return the parameter whose value will be the exception that was thrown.
   * @return the parameter whose value will be the exception that was thrown
   */
  SimpleIdentifier get exceptionParameter => _exceptionParameter;
  /**
   * Return the type of exceptions caught by this catch clause, or {@code null} if this catch clause
   * catches every type of exception.
   * @return the type of exceptions caught by this catch clause
   */
  TypeName get exceptionType => _exceptionType;
  /**
   * Return the left parenthesis.
   * @return the left parenthesis
   */
  Token get leftParenthesis => _leftParenthesis;
  /**
   * Return the token representing the 'on' keyword, or {@code null} if there is no 'on' keyword.
   * @return the token representing the 'on' keyword
   */
  Token get onKeyword => _onKeyword;
  /**
   * Return the right parenthesis.
   * @return the right parenthesis
   */
  Token get rightParenthesis => _rightParenthesis;
  /**
   * Return the parameter whose value will be the stack trace associated with the exception.
   * @return the parameter whose value will be the stack trace associated with the exception
   */
  SimpleIdentifier get stackTraceParameter => _stackTraceParameter;
  /**
   * Set the body of the catch block to the given block.
   * @param block the body of the catch block
   */
  void set body2(Block block) {
    _body = becomeParentOf(block);
  }
  /**
   * Set the token representing the 'catch' keyword to the given token.
   * @param catchKeyword the token representing the 'catch' keyword
   */
  void set catchKeyword2(Token catchKeyword) {
    this._catchKeyword = catchKeyword;
  }
  /**
   * Set the comma to the given token.
   * @param comma the comma
   */
  void set comma2(Token comma) {
    this._comma = comma;
  }
  /**
   * Set the parameter whose value will be the exception that was thrown to the given parameter.
   * @param parameter the parameter whose value will be the exception that was thrown
   */
  void set exceptionParameter2(SimpleIdentifier parameter) {
    _exceptionParameter = becomeParentOf(parameter);
  }
  /**
   * Set the type of exceptions caught by this catch clause to the given type.
   * @param exceptionType the type of exceptions caught by this catch clause
   */
  void set exceptionType2(TypeName exceptionType) {
    this._exceptionType = exceptionType;
  }
  /**
   * Set the left parenthesis to the given token.
   * @param parenthesis the left parenthesis
   */
  void set leftParenthesis4(Token parenthesis) {
    _leftParenthesis = parenthesis;
  }
  /**
   * Set the token representing the 'on' keyword to the given keyword.
   * @param onKeyword the token representing the 'on' keyword
   */
  void set onKeyword2(Token onKeyword) {
    this._onKeyword = onKeyword;
  }
  /**
   * Set the right parenthesis to the given token.
   * @param parenthesis the right parenthesis
   */
  void set rightParenthesis4(Token parenthesis) {
    _rightParenthesis = parenthesis;
  }
  /**
   * Set the parameter whose value will be the stack trace associated with the exception to the
   * given parameter.
   * @param parameter the parameter whose value will be the stack trace associated with the
   * exception
   */
  void set stackTraceParameter2(SimpleIdentifier parameter) {
    _stackTraceParameter = becomeParentOf(parameter);
  }
  void visitChildren(ASTVisitor<Object> visitor) {
    safelyVisitChild(_exceptionType, visitor);
    safelyVisitChild(_exceptionParameter, visitor);
    safelyVisitChild(_stackTraceParameter, visitor);
    safelyVisitChild(_body, visitor);
  }
}
/**
 * Instances of the class {@code ClassDeclaration} represent the declaration of a class.
 * <pre>
 * classDeclaration ::=
 * 'abstract'? 'class' {@link SimpleIdentifier name} {@link TypeParameterList typeParameterList}?
 * ({@link ExtendsClause extendsClause} {@link WithClause withClause}?)?{@link ImplementsClause implementsClause}?
 * '{' {@link ClassMember classMember}* '}'
 * </pre>
 */
class ClassDeclaration extends CompilationUnitMember {
  /**
   * The 'abstract' keyword, or {@code null} if the keyword was absent.
   */
  Token _abstractKeyword;
  /**
   * The token representing the 'class' keyword.
   */
  Token _classKeyword;
  /**
   * The name of the class being declared.
   */
  SimpleIdentifier _name;
  /**
   * The type parameters for the class, or {@code null} if the class does not have any type
   * parameters.
   */
  TypeParameterList _typeParameters;
  /**
   * The extends clause for the class, or {@code null} if the class does not extend any other class.
   */
  ExtendsClause _extendsClause;
  /**
   * The with clause for the class, or {@code null} if the class does not have a with clause.
   */
  WithClause _withClause;
  /**
   * The implements clause for the class, or {@code null} if the class does not implement any
   * interfaces.
   */
  ImplementsClause _implementsClause;
  /**
   * The left curly bracket.
   */
  Token _leftBracket;
  /**
   * The members defined by the class.
   */
  NodeList<ClassMember> _members;
  /**
   * The right curly bracket.
   */
  Token _rightBracket;
  /**
   * Initialize a newly created class declaration.
   * @param comment the documentation comment associated with this class
   * @param metadata the annotations associated with this class
   * @param abstractKeyword the 'abstract' keyword, or {@code null} if the keyword was absent
   * @param classKeyword the token representing the 'class' keyword
   * @param name the name of the class being declared
   * @param typeParameters the type parameters for the class
   * @param extendsClause the extends clause for the class
   * @param withClause the with clause for the class
   * @param implementsClause the implements clause for the class
   * @param leftBracket the left curly bracket
   * @param members the members defined by the class
   * @param rightBracket the right curly bracket
   */
  ClassDeclaration(Comment comment, List<Annotation> metadata, Token abstractKeyword, Token classKeyword, SimpleIdentifier name, TypeParameterList typeParameters, ExtendsClause extendsClause, WithClause withClause, ImplementsClause implementsClause, Token leftBracket, List<ClassMember> members, Token rightBracket) : super(comment, metadata) {
    this._members = new NodeList<ClassMember>(this);
    this._abstractKeyword = abstractKeyword;
    this._classKeyword = classKeyword;
    this._name = becomeParentOf(name);
    this._typeParameters = becomeParentOf(typeParameters);
    this._extendsClause = becomeParentOf(extendsClause);
    this._withClause = becomeParentOf(withClause);
    this._implementsClause = becomeParentOf(implementsClause);
    this._leftBracket = leftBracket;
    this._members.addAll(members);
    this._rightBracket = rightBracket;
  }
  accept(ASTVisitor visitor) => visitor.visitClassDeclaration(this);
  /**
   * Return the 'abstract' keyword, or {@code null} if the keyword was absent.
   * @return the 'abstract' keyword
   */
  Token get abstractKeyword => _abstractKeyword;
  /**
   * Return the token representing the 'class' keyword.
   * @return the token representing the 'class' keyword
   */
  Token get classKeyword => _classKeyword;
  /**
   * @return the {@link ClassElement} associated with this identifier, or {@code null} if the AST
   * structure has not been resolved or if this identifier could not be resolved.
   */
  ClassElement get element => _name != null ? _name.element as ClassElement : null;
  Token get endToken => _rightBracket;
  /**
   * Return the extends clause for this class, or {@code null} if the class does not extend any
   * other class.
   * @return the extends clause for this class
   */
  ExtendsClause get extendsClause => _extendsClause;
  /**
   * Return the implements clause for the class, or {@code null} if the class does not implement any
   * interfaces.
   * @return the implements clause for the class
   */
  ImplementsClause get implementsClause => _implementsClause;
  /**
   * Return the left curly bracket.
   * @return the left curly bracket
   */
  Token get leftBracket => _leftBracket;
  /**
   * Return the members defined by the class.
   * @return the members defined by the class
   */
  NodeList<ClassMember> get members => _members;
  /**
   * Return the name of the class being declared.
   * @return the name of the class being declared
   */
  SimpleIdentifier get name => _name;
  /**
   * Return the right curly bracket.
   * @return the right curly bracket
   */
  Token get rightBracket => _rightBracket;
  /**
   * Return the type parameters for the class, or {@code null} if the class does not have any type
   * parameters.
   * @return the type parameters for the class
   */
  TypeParameterList get typeParameters => _typeParameters;
  /**
   * Return the with clause for the class, or {@code null} if the class does not have a with clause.
   * @return the with clause for the class
   */
  WithClause get withClause => _withClause;
  /**
   * Set the 'abstract' keyword to the given keyword.
   * @param abstractKeyword the 'abstract' keyword
   */
  void set abstractKeyword2(Token abstractKeyword) {
    this._abstractKeyword = abstractKeyword;
  }
  /**
   * Set the token representing the 'class' keyword to the given token.
   * @param classKeyword the token representing the 'class' keyword
   */
  void set classKeyword2(Token classKeyword) {
    this._classKeyword = classKeyword;
  }
  /**
   * Set the extends clause for this class to the given clause.
   * @param extendsClause the extends clause for this class
   */
  void set extendsClause2(ExtendsClause extendsClause) {
    this._extendsClause = becomeParentOf(extendsClause);
  }
  /**
   * Set the implements clause for the class to the given clause.
   * @param implementsClause the implements clause for the class
   */
  void set implementsClause2(ImplementsClause implementsClause) {
    this._implementsClause = becomeParentOf(implementsClause);
  }
  /**
   * Set the left curly bracket to the given token.
   * @param leftBracket the left curly bracket
   */
  void set leftBracket3(Token leftBracket) {
    this._leftBracket = leftBracket;
  }
  /**
   * Set the name of the class being declared to the given identifier.
   * @param identifier the name of the class being declared
   */
  void set name3(SimpleIdentifier identifier) {
    _name = becomeParentOf(identifier);
  }
  /**
   * Set the right curly bracket to the given token.
   * @param rightBracket the right curly bracket
   */
  void set rightBracket3(Token rightBracket) {
    this._rightBracket = rightBracket;
  }
  /**
   * Set the type parameters for the class to the given list of type parameters.
   * @param typeParameters the type parameters for the class
   */
  void set typeParameters2(TypeParameterList typeParameters) {
    this._typeParameters = typeParameters;
  }
  /**
   * Set the with clause for the class to the given clause.
   * @param withClause the with clause for the class
   */
  void set withClause2(WithClause withClause) {
    this._withClause = becomeParentOf(withClause);
  }
  void visitChildren(ASTVisitor<Object> visitor) {
    safelyVisitChild(documentationComment, visitor);
    safelyVisitChild(_name, visitor);
    safelyVisitChild(_typeParameters, visitor);
    safelyVisitChild(_extendsClause, visitor);
    safelyVisitChild(_withClause, visitor);
    safelyVisitChild(_implementsClause, visitor);
    members.accept(visitor);
  }
  Token get firstTokenAfterCommentAndMetadata {
    if (_abstractKeyword != null) {
      return _abstractKeyword;
    }
    return _classKeyword;
  }
}
/**
 * The abstract class {@code ClassMember} defines the behavior common to nodes that declare a name
 * within the scope of a class.
 */
abstract class ClassMember extends Declaration {
  /**
   * Initialize a newly created member of a class.
   * @param comment the documentation comment associated with this member
   * @param metadata the annotations associated with this member
   */
  ClassMember(Comment comment, List<Annotation> metadata) : super(comment, metadata) {
  }
}
/**
 * Instances of the class {@code ClassTypeAlias} represent a class type alias.
 * <pre>
 * classTypeAlias ::={@link SimpleIdentifier identifier} {@link TypeParameterList typeParameters}? '=' 'abstract'? mixinApplication
 * mixinApplication ::={@link TypeName superclass} {@link WithClause withClause} {@link ImplementsClause implementsClause}? ';'
 * </pre>
 */
class ClassTypeAlias extends TypeAlias {
  /**
   * The name of the class being declared.
   */
  SimpleIdentifier _name;
  /**
   * The type parameters for the class, or {@code null} if the class does not have any type
   * parameters.
   */
  TypeParameterList _typeParameters;
  /**
   * The token for the '=' separating the name from the definition.
   */
  Token _equals;
  /**
   * The token for the 'abstract' keyword, or {@code null} if this is not defining an abstract
   * class.
   */
  Token _abstractKeyword;
  /**
   * The name of the superclass of the class being declared.
   */
  TypeName _superclass;
  /**
   * The with clause for this class.
   */
  WithClause _withClause;
  /**
   * The implements clause for this class, or {@code null} if there is no implements clause.
   */
  ImplementsClause _implementsClause;
  /**
   * Initialize a newly created class type alias.
   * @param comment the documentation comment associated with this type alias
   * @param metadata the annotations associated with this type alias
   * @param keyword the token representing the 'typedef' keyword
   * @param name the name of the class being declared
   * @param typeParameters the type parameters for the class
   * @param equals the token for the '=' separating the name from the definition
   * @param abstractKeyword the token for the 'abstract' keyword
   * @param superclass the name of the superclass of the class being declared
   * @param withClause the with clause for this class
   * @param implementsClause the implements clause for this class
   * @param semicolon the semicolon terminating the declaration
   */
  ClassTypeAlias(Comment comment, List<Annotation> metadata, Token keyword, SimpleIdentifier name, TypeParameterList typeParameters, Token equals, Token abstractKeyword, TypeName superclass, WithClause withClause, ImplementsClause implementsClause, Token semicolon) : super(comment, metadata, keyword, semicolon) {
    this._name = becomeParentOf(name);
    this._typeParameters = becomeParentOf(typeParameters);
    this._equals = equals;
    this._abstractKeyword = abstractKeyword;
    this._superclass = becomeParentOf(superclass);
    this._withClause = becomeParentOf(withClause);
    this._implementsClause = becomeParentOf(implementsClause);
  }
  accept(ASTVisitor visitor) => visitor.visitClassTypeAlias(this);
  /**
   * Return the token for the 'abstract' keyword, or {@code null} if this is not defining an
   * abstract class.
   * @return the token for the 'abstract' keyword
   */
  Token get abstractKeyword => _abstractKeyword;
  /**
   * Return the {@link ClassElement} associated with this type alias, or {@code null} if the AST
   * structure has not been resolved.
   * @return the {@link ClassElement} associated with this type alias
   */
  ClassElement get element => _name != null ? _name.element as ClassElement : null;
  /**
   * Return the token for the '=' separating the name from the definition.
   * @return the token for the '=' separating the name from the definition
   */
  Token get equals => _equals;
  /**
   * Return the implements clause for this class, or {@code null} if there is no implements clause.
   * @return the implements clause for this class
   */
  ImplementsClause get implementsClause => _implementsClause;
  /**
   * Return the name of the class being declared.
   * @return the name of the class being declared
   */
  SimpleIdentifier get name => _name;
  /**
   * Return the name of the superclass of the class being declared.
   * @return the name of the superclass of the class being declared
   */
  TypeName get superclass => _superclass;
  /**
   * Return the type parameters for the class, or {@code null} if the class does not have any type
   * parameters.
   * @return the type parameters for the class
   */
  TypeParameterList get typeParameters => _typeParameters;
  /**
   * Return the with clause for this class.
   * @return the with clause for this class
   */
  WithClause get withClause => _withClause;
  /**
   * Set the token for the 'abstract' keyword to the given token.
   * @param abstractKeyword the token for the 'abstract' keyword
   */
  void set abstractKeyword3(Token abstractKeyword) {
    this._abstractKeyword = abstractKeyword;
  }
  /**
   * Set the token for the '=' separating the name from the definition to the given token.
   * @param equals the token for the '=' separating the name from the definition
   */
  void set equals4(Token equals) {
    this._equals = equals;
  }
  /**
   * Set the implements clause for this class to the given implements clause.
   * @param implementsClause the implements clause for this class
   */
  void set implementsClause3(ImplementsClause implementsClause) {
    this._implementsClause = becomeParentOf(implementsClause);
  }
  /**
   * Set the name of the class being declared to the given identifier.
   * @param name the name of the class being declared
   */
  void set name4(SimpleIdentifier name) {
    this._name = becomeParentOf(name);
  }
  /**
   * Set the name of the superclass of the class being declared to the given name.
   * @param superclass the name of the superclass of the class being declared
   */
  void set superclass2(TypeName superclass) {
    this._superclass = becomeParentOf(superclass);
  }
  /**
   * Set the type parameters for the class to the given list of parameters.
   * @param typeParameters the type parameters for the class
   */
  void set typeParameters3(TypeParameterList typeParameters) {
    this._typeParameters = becomeParentOf(typeParameters);
  }
  /**
   * Set the with clause for this class to the given with clause.
   * @param withClause the with clause for this class
   */
  void set withClause3(WithClause withClause) {
    this._withClause = becomeParentOf(withClause);
  }
  void visitChildren(ASTVisitor<Object> visitor) {
    super.visitChildren(visitor);
    safelyVisitChild(_name, visitor);
    safelyVisitChild(_typeParameters, visitor);
    safelyVisitChild(_superclass, visitor);
    safelyVisitChild(_withClause, visitor);
    safelyVisitChild(_implementsClause, visitor);
  }
}
/**
 * Instances of the class {@code Combinator} represent the combinator associated with an import
 * directive.
 * <pre>
 * combinator ::={@link HideCombinator hideCombinator}| {@link ShowCombinator showCombinator}</pre>
 */
abstract class Combinator extends ASTNode {
  /**
   * The keyword specifying what kind of processing is to be done on the imported names.
   */
  Token _keyword;
  /**
   * Initialize a newly created import combinator.
   * @param keyword the keyword specifying what kind of processing is to be done on the imported
   * names
   */
  Combinator(Token keyword) {
    this._keyword = keyword;
  }
  Token get beginToken => _keyword;
  /**
   * Return the keyword specifying what kind of processing is to be done on the imported names.
   * @return the keyword specifying what kind of processing is to be done on the imported names
   */
  Token get keyword => _keyword;
  /**
   * Set the keyword specifying what kind of processing is to be done on the imported names to the
   * given token.
   * @param keyword the keyword specifying what kind of processing is to be done on the imported
   * names
   */
  void set keyword5(Token keyword) {
    this._keyword = keyword;
  }
}
/**
 * Instances of the class {@code Comment} represent a comment within the source code.
 * <pre>
 * comment ::=
 * endOfLineComment
 * | blockComment
 * | documentationComment
 * endOfLineComment ::=
 * '//' (CHARACTER - EOL)* EOL
 * blockComment ::=
 * '/ *' CHARACTER* '&#42;/'
 * documentationComment ::=
 * '/ **' (CHARACTER | {@link CommentReference commentReference})* '&#42;/'
 * | ('///' (CHARACTER - EOL)* EOL)+
 * </pre>
 */
class Comment extends ASTNode {
  /**
   * Create a block comment.
   * @param tokens the tokens representing the comment
   * @return the block comment that was created
   */
  static Comment createBlockComment(List<Token> tokens) => new Comment(tokens, CommentType.BLOCK, null);
  /**
   * Create a documentation comment.
   * @param tokens the tokens representing the comment
   * @return the documentation comment that was created
   */
  static Comment createDocumentationComment(List<Token> tokens) => new Comment(tokens, CommentType.DOCUMENTATION, new List<CommentReference>());
  /**
   * Create a documentation comment.
   * @param tokens the tokens representing the comment
   * @param references the references embedded within the documentation comment
   * @return the documentation comment that was created
   */
  static Comment createDocumentationComment2(List<Token> tokens, List<CommentReference> references) => new Comment(tokens, CommentType.DOCUMENTATION, references);
  /**
   * Create an end-of-line comment.
   * @param tokens the tokens representing the comment
   * @return the end-of-line comment that was created
   */
  static Comment createEndOfLineComment(List<Token> tokens) => new Comment(tokens, CommentType.END_OF_LINE, null);
  /**
   * The tokens representing the comment.
   */
  List<Token> _tokens;
  /**
   * The type of the comment.
   */
  CommentType _type;
  /**
   * The references embedded within the documentation comment. This list will be empty unless this
   * is a documentation comment that has references embedded within it.
   */
  NodeList<CommentReference> _references;
  /**
   * Initialize a newly created comment.
   * @param tokens the tokens representing the comment
   * @param type the type of the comment
   * @param references the references embedded within the documentation comment
   */
  Comment(List<Token> tokens, CommentType type, List<CommentReference> references) {
    this._references = new NodeList<CommentReference>(this);
    this._tokens = tokens;
    this._type = type;
    this._references.addAll(references);
  }
  accept(ASTVisitor visitor) => visitor.visitComment(this);
  Token get beginToken => _tokens[0];
  Token get endToken => _tokens[_tokens.length - 1];
  /**
   * Return the references embedded within the documentation comment.
   * @return the references embedded within the documentation comment
   */
  NodeList<CommentReference> get references => _references;
  /**
   * Return {@code true} if this is a block comment.
   * @return {@code true} if this is a block comment
   */
  bool isBlock() => _type == CommentType.BLOCK;
  /**
   * Return {@code true} if this is a documentation comment.
   * @return {@code true} if this is a documentation comment
   */
  bool isDocumentation() => _type == CommentType.DOCUMENTATION;
  /**
   * Return {@code true} if this is an end-of-line comment.
   * @return {@code true} if this is an end-of-line comment
   */
  bool isEndOfLine() => _type == CommentType.END_OF_LINE;
  void visitChildren(ASTVisitor<Object> visitor) {
    _references.accept(visitor);
  }
}
/**
 * The enumeration {@code CommentType} encodes all the different types of comments that are
 * recognized by the parser.
 */
class CommentType {
  /**
   * An end-of-line comment.
   */
  static final CommentType END_OF_LINE = new CommentType('END_OF_LINE', 0);
  /**
   * A block comment.
   */
  static final CommentType BLOCK = new CommentType('BLOCK', 1);
  /**
   * A documentation comment.
   */
  static final CommentType DOCUMENTATION = new CommentType('DOCUMENTATION', 2);
  static final List<CommentType> values = [END_OF_LINE, BLOCK, DOCUMENTATION];
  final String __name;
  final int __ordinal;
  CommentType(this.__name, this.__ordinal) {
  }
  String toString() => __name;
}
/**
 * Instances of the class {@code CommentReference} represent a reference to a Dart element that is
 * found within a documentation comment.
 * <pre>
 * commentReference ::=
 * '[' 'new'? {@link Identifier identifier} ']'
 * </pre>
 */
class CommentReference extends ASTNode {
  /**
   * The token representing the 'new' keyword, or {@code null} if there was no 'new' keyword.
   */
  Token _newKeyword;
  /**
   * The identifier being referenced.
   */
  Identifier _identifier;
  /**
   * Initialize a newly created reference to a Dart element.
   * @param newKeyword the token representing the 'new' keyword
   * @param identifier the identifier being referenced
   */
  CommentReference(Token newKeyword, Identifier identifier) {
    this._newKeyword = newKeyword;
    this._identifier = becomeParentOf(identifier);
  }
  accept(ASTVisitor visitor) => visitor.visitCommentReference(this);
  Token get beginToken => _identifier.beginToken;
  Token get endToken => _identifier.endToken;
  /**
   * Return the identifier being referenced.
   * @return the identifier being referenced
   */
  Identifier get identifier => _identifier;
  /**
   * Return the token representing the 'new' keyword, or {@code null} if there was no 'new' keyword.
   * @return the token representing the 'new' keyword
   */
  Token get newKeyword => _newKeyword;
  /**
   * Set the identifier being referenced to the given identifier.
   * @param identifier the identifier being referenced
   */
  void set identifier3(Identifier identifier) {
    identifier = becomeParentOf(identifier);
  }
  /**
   * Set the token representing the 'new' keyword to the given token.
   * @param newKeyword the token representing the 'new' keyword
   */
  void set newKeyword2(Token newKeyword) {
    this._newKeyword = newKeyword;
  }
  void visitChildren(ASTVisitor<Object> visitor) {
    safelyVisitChild(_identifier, visitor);
  }
}
/**
 * Instances of the class {@code CompilationUnit} represent a compilation unit.
 * <p>
 * While the grammar restricts the order of the directives and declarations within a compilation
 * unit, this class does not enforce those restrictions. In particular, the children of a
 * compilation unit will be visited in lexical order even if lexical order does not conform to the
 * restrictions of the grammar.
 * <pre>
 * compilationUnit ::=
 * directives declarations
 * directives ::={@link ScriptTag scriptTag}? {@link LibraryDirective libraryDirective}? namespaceDirective* {@link PartDirective partDirective}| {@link PartOfDirective partOfDirective}namespaceDirective ::={@link ImportDirective importDirective}| {@link ExportDirective exportDirective}declarations ::={@link CompilationUnitMember compilationUnitMember}</pre>
 */
class CompilationUnit extends ASTNode {
  /**
   * The first token in the token stream that was parsed to form this compilation unit.
   */
  Token _beginToken;
  /**
   * The script tag at the beginning of the compilation unit, or {@code null} if there is no script
   * tag in this compilation unit.
   */
  ScriptTag _scriptTag;
  /**
   * The directives contained in this compilation unit.
   */
  NodeList<Directive> _directives;
  /**
   * The declarations contained in this compilation unit.
   */
  NodeList<CompilationUnitMember> _declarations;
  /**
   * The last token in the token stream that was parsed to form this compilation unit. This token
   * should always have a type of {@link TokenType.EOF}.
   */
  Token _endToken;
  /**
   * The element associated with this compilation unit, or {@code null} if the AST structure has not
   * been resolved.
   */
  CompilationUnitElement _element;
  /**
   * The syntax errors encountered when the receiver was parsed.
   */
  List<AnalysisError> _syntacticErrors;
  /**
   * Initialize a newly created compilation unit to have the given directives and declarations.
   * @param beginToken the first token in the token stream
   * @param scriptTag the script tag at the beginning of the compilation unit
   * @param directives the directives contained in this compilation unit
   * @param declarations the declarations contained in this compilation unit
   * @param endToken the last token in the token stream
   */
  CompilationUnit(Token beginToken, ScriptTag scriptTag, List<Directive> directives, List<CompilationUnitMember> declarations, Token endToken) {
    this._directives = new NodeList<Directive>(this);
    this._declarations = new NodeList<CompilationUnitMember>(this);
    this._beginToken = beginToken;
    this._scriptTag = becomeParentOf(scriptTag);
    this._directives.addAll(directives);
    this._declarations.addAll(declarations);
    this._endToken = endToken;
  }
  accept(ASTVisitor visitor) => visitor.visitCompilationUnit(this);
  Token get beginToken => _beginToken;
  /**
   * Return the declarations contained in this compilation unit.
   * @return the declarations contained in this compilation unit
   */
  NodeList<CompilationUnitMember> get declarations => _declarations;
  /**
   * Return the directives contained in this compilation unit.
   * @return the directives contained in this compilation unit
   */
  NodeList<Directive> get directives => _directives;
  /**
   * Return the element associated with this compilation unit, or {@code null} if the AST structure
   * has not been resolved.
   * @return the element associated with this compilation unit
   */
  CompilationUnitElement get element => _element;
  Token get endToken => _endToken;
  /**
   * Return an array containing all of the errors associated with the receiver. If the receiver has
   * not been resolved, then return {@code null}.
   * @return an array of errors (contains no {@code null}s) or {@code null} if the receiver has not
   * been resolved
   */
  List<AnalysisError> get errors {
    throw new UnsupportedOperationException();
  }
  int get length {
    Token endToken4 = endToken;
    if (endToken4 == null) {
      return 0;
    }
    return endToken4.offset + endToken4.length - beginToken.offset;
  }
  int get offset {
    Token beginToken4 = beginToken;
    if (beginToken4 == null) {
      return 0;
    }
    return beginToken4.offset;
  }
  /**
   * Return the script tag at the beginning of the compilation unit, or {@code null} if there is no
   * script tag in this compilation unit.
   * @return the script tag at the beginning of the compilation unit
   */
  ScriptTag get scriptTag => _scriptTag;
  /**
   * Return an array containing all of the semantic errors associated with the receiver. If the
   * receiver has not been resolved, then return {@code null}.
   * @return an array of errors (contains no {@code null}s) or {@code null} if the receiver has not
   * been resolved
   */
  List<AnalysisError> get semanticErrors {
    throw new UnsupportedOperationException();
  }
  /**
   * Return an array containing all of the syntactic errors associated with the receiver.
   * @return an array of errors (not {@code null}, contains no {@code null}s).
   */
  List<AnalysisError> get syntacticErrors => _syntacticErrors;
  /**
   * Set the element associated with this compilation unit to the given element.
   * @param element the element associated with this compilation unit
   */
  void set element4(CompilationUnitElement element) {
    this._element = element;
  }
  /**
   * Set the script tag at the beginning of the compilation unit to the given script tag.
   * @param scriptTag the script tag at the beginning of the compilation unit
   */
  void set scriptTag2(ScriptTag scriptTag) {
    this._scriptTag = becomeParentOf(scriptTag);
  }
  /**
   * Called by the {@link AnalysisContext} to cache the syntax errors when the unit is parsed.
   * @param errors an array of syntax errors (not {@code null}, contains no {@code null}s)
   */
  void set syntacticErrors2(List<AnalysisError> errors) {
    this._syntacticErrors = errors;
  }
  void visitChildren(ASTVisitor<Object> visitor) {
    safelyVisitChild(_scriptTag, visitor);
    if (directivesAreBeforeDeclarations()) {
      _directives.accept(visitor);
      _declarations.accept(visitor);
    } else {
      for (ASTNode child in sortedDirectivesAndDeclarations) {
        child.accept(visitor);
      }
    }
  }
  /**
   * Return {@code true} if all of the directives are lexically before any declarations.
   * @return {@code true} if all of the directives are lexically before any declarations
   */
  bool directivesAreBeforeDeclarations() {
    if (_directives.isEmpty || _declarations.isEmpty) {
      return true;
    }
    Directive lastDirective = _directives[_directives.length - 1];
    CompilationUnitMember firstDeclaration = _declarations[0];
    return lastDirective.offset < firstDeclaration.offset;
  }
  /**
   * Return an array containing all of the directives and declarations in this compilation unit,
   * sorted in lexical order.
   * @return the directives and declarations in this compilation unit in the order in which they
   * appeared in the original source
   */
  List<ASTNode> get sortedDirectivesAndDeclarations {
    List<ASTNode> childList = new List<ASTNode>();
    childList.addAll(_directives);
    childList.addAll(_declarations);
    List<ASTNode> children = new List.from(childList);
    children.sort();
    return children;
  }
}
/**
 * Instances of the class {@code CompilationUnitMember} defines the behavior common to nodes that
 * declare a name within the scope of a compilation unit.
 * <pre>
 * compilationUnitMember ::={@link ClassDeclaration classDeclaration}| {@link TypeAlias typeAlias}| {@link FunctionDeclaration functionDeclaration}| {@link MethodDeclaration getOrSetDeclaration}| {@link VariableDeclaration constantsDeclaration}| {@link VariableDeclaration variablesDeclaration}</pre>
 */
abstract class CompilationUnitMember extends Declaration {
  /**
   * Initialize a newly created generic compilation unit member.
   * @param comment the documentation comment associated with this member
   * @param metadata the annotations associated with this member
   */
  CompilationUnitMember(Comment comment, List<Annotation> metadata) : super(comment, metadata) {
  }
}
/**
 * Instances of the class {@code ConditionalExpression} represent a conditional expression.
 * <pre>
 * conditionalExpression ::={@link Expression condition} '?' {@link Expression thenExpression} ':' {@link Expression elseExpression}</pre>
 */
class ConditionalExpression extends Expression {
  /**
   * The condition used to determine which of the expressions is executed next.
   */
  Expression _condition;
  /**
   * The token used to separate the condition from the then expression.
   */
  Token _question;
  /**
   * The expression that is executed if the condition evaluates to {@code true}.
   */
  Expression _thenExpression;
  /**
   * The token used to separate the then expression from the else expression.
   */
  Token _colon;
  /**
   * The expression that is executed if the condition evaluates to {@code false}.
   */
  Expression _elseExpression;
  /**
   * Initialize a newly created conditional expression.
   * @param condition the condition used to determine which expression is executed next
   * @param question the token used to separate the condition from the then expression
   * @param thenExpression the expression that is executed if the condition evaluates to{@code true}
   * @param colon the token used to separate the then expression from the else expression
   * @param elseExpression the expression that is executed if the condition evaluates to{@code false}
   */
  ConditionalExpression(Expression condition, Token question, Expression thenExpression, Token colon, Expression elseExpression) {
    this._condition = becomeParentOf(condition);
    this._question = question;
    this._thenExpression = becomeParentOf(thenExpression);
    this._colon = colon;
    this._elseExpression = becomeParentOf(elseExpression);
  }
  accept(ASTVisitor visitor) => visitor.visitConditionalExpression(this);
  Token get beginToken => _condition.beginToken;
  /**
   * Return the token used to separate the then expression from the else expression.
   * @return the token used to separate the then expression from the else expression
   */
  Token get colon => _colon;
  /**
   * Return the condition used to determine which of the expressions is executed next.
   * @return the condition used to determine which expression is executed next
   */
  Expression get condition => _condition;
  /**
   * Return the expression that is executed if the condition evaluates to {@code false}.
   * @return the expression that is executed if the condition evaluates to {@code false}
   */
  Expression get elseExpression => _elseExpression;
  Token get endToken => _elseExpression.endToken;
  /**
   * Return the token used to separate the condition from the then expression.
   * @return the token used to separate the condition from the then expression
   */
  Token get question => _question;
  /**
   * Return the expression that is executed if the condition evaluates to {@code true}.
   * @return the expression that is executed if the condition evaluates to {@code true}
   */
  Expression get thenExpression => _thenExpression;
  /**
   * Set the token used to separate the then expression from the else expression to the given token.
   * @param colon the token used to separate the then expression from the else expression
   */
  void set colon2(Token colon) {
    this._colon = colon;
  }
  /**
   * Set the condition used to determine which of the expressions is executed next to the given
   * expression.
   * @param expression the condition used to determine which expression is executed next
   */
  void set condition3(Expression expression) {
    _condition = becomeParentOf(expression);
  }
  /**
   * Set the expression that is executed if the condition evaluates to {@code false} to the given
   * expression.
   * @param expression the expression that is executed if the condition evaluates to {@code false}
   */
  void set elseExpression2(Expression expression) {
    _elseExpression = becomeParentOf(expression);
  }
  /**
   * Set the token used to separate the condition from the then expression to the given token.
   * @param question the token used to separate the condition from the then expression
   */
  void set question3(Token question) {
    this._question = question;
  }
  /**
   * Set the expression that is executed if the condition evaluates to {@code true} to the given
   * expression.
   * @param expression the expression that is executed if the condition evaluates to {@code true}
   */
  void set thenExpression2(Expression expression) {
    _thenExpression = becomeParentOf(expression);
  }
  void visitChildren(ASTVisitor<Object> visitor) {
    safelyVisitChild(_condition, visitor);
    safelyVisitChild(_thenExpression, visitor);
    safelyVisitChild(_elseExpression, visitor);
  }
}
/**
 * Instances of the class {@code ConstructorDeclaration} represent a constructor declaration.
 * <pre>
 * constructorDeclaration ::=
 * constructorSignature {@link FunctionBody body}?
 * | constructorName formalParameterList ':' 'this' ('.' {@link SimpleIdentifier name})? arguments
 * constructorSignature ::=
 * 'external'? constructorName formalParameterList initializerList?
 * | 'external'? 'factory' factoryName formalParameterList initializerList?
 * | 'external'? 'const'  constructorName formalParameterList initializerList?
 * constructorName ::={@link SimpleIdentifier returnType} ('.' {@link SimpleIdentifier name})?
 * factoryName ::={@link Identifier returnType} ('.' {@link SimpleIdentifier name})?
 * initializerList ::=
 * ':' {@link ConstructorInitializer initializer} (',' {@link ConstructorInitializer initializer})
 * </pre>
 */
class ConstructorDeclaration extends ClassMember {
  /**
   * The token for the 'external' keyword, or {@code null} if the constructor is not external.
   */
  Token _externalKeyword;
  /**
   * The token for the 'const' keyword.
   */
  Token _constKeyword;
  /**
   * The token for the 'factory' keyword.
   */
  Token _factoryKeyword;
  /**
   * The type of object being created. This can be different than the type in which the constructor
   * is being declared if the constructor is the implementation of a factory constructor.
   */
  Identifier _returnType;
  /**
   * The token for the period before the constructor name, or {@code null} if the constructor being
   * declared is unnamed.
   */
  Token _period;
  /**
   * The name of the constructor, or {@code null} if the constructor being declared is unnamed.
   */
  SimpleIdentifier _name;
  /**
   * The element associated with this constructor, or {@code null} if the AST structure has not been
   * resolved or if this constructor could not be resolved.
   */
  ConstructorElement _element;
  /**
   * The parameters associated with the constructor.
   */
  FormalParameterList _parameters;
  /**
   * The token for the separator (colon or equals) before the initializers, or {@code null} if there
   * are no initializers.
   */
  Token _separator;
  /**
   * The initializers associated with the constructor.
   */
  NodeList<ConstructorInitializer> _initializers;
  /**
   * The name of the constructor to which this constructor will be redirected, or {@code null} if
   * this is not a redirecting factory constructor.
   */
  ConstructorName _redirectedConstructor;
  /**
   * The body of the constructor, or {@code null} if the constructor does not have a body.
   */
  FunctionBody _body;
  /**
   * Initialize a newly created constructor declaration.
   * @param externalKeyword the token for the 'external' keyword
   * @param comment the documentation comment associated with this constructor
   * @param metadata the annotations associated with this constructor
   * @param constKeyword the token for the 'const' keyword
   * @param factoryKeyword the token for the 'factory' keyword
   * @param returnType the return type of the constructor
   * @param period the token for the period before the constructor name
   * @param name the name of the constructor
   * @param parameters the parameters associated with the constructor
   * @param separator the token for the colon or equals before the initializers
   * @param initializers the initializers associated with the constructor
   * @param redirectedConstructor the name of the constructor to which this constructor will be
   * redirected
   * @param body the body of the constructor
   */
  ConstructorDeclaration(Comment comment, List<Annotation> metadata, Token externalKeyword, Token constKeyword, Token factoryKeyword, Identifier returnType, Token period, SimpleIdentifier name, FormalParameterList parameters, Token separator, List<ConstructorInitializer> initializers, ConstructorName redirectedConstructor, FunctionBody body) : super(comment, metadata) {
    this._initializers = new NodeList<ConstructorInitializer>(this);
    this._externalKeyword = externalKeyword;
    this._constKeyword = constKeyword;
    this._factoryKeyword = factoryKeyword;
    this._returnType = becomeParentOf(returnType);
    this._period = period;
    this._name = becomeParentOf(name);
    this._parameters = becomeParentOf(parameters);
    this._separator = separator;
    this._initializers.addAll(initializers);
    this._redirectedConstructor = becomeParentOf(redirectedConstructor);
    this._body = becomeParentOf(body);
  }
  accept(ASTVisitor visitor) => visitor.visitConstructorDeclaration(this);
  /**
   * Return the body of the constructor, or {@code null} if the constructor does not have a body.
   * @return the body of the constructor
   */
  FunctionBody get body => _body;
  /**
   * Return the token for the 'const' keyword.
   * @return the token for the 'const' keyword
   */
  Token get constKeyword => _constKeyword;
  /**
   * Return the element associated with this constructor , or {@code null} if the AST structure has
   * not been resolved or if this constructor could not be resolved.
   * @return the element associated with this constructor
   */
  ConstructorElement get element => _element;
  Token get endToken {
    if (_body != null) {
      return _body.endToken;
    } else if (!_initializers.isEmpty) {
      return _initializers.endToken;
    }
    return _parameters.endToken;
  }
  /**
   * Return the token for the 'external' keyword, or {@code null} if the constructor is not
   * external.
   * @return the token for the 'external' keyword
   */
  Token get externalKeyword => _externalKeyword;
  /**
   * Return the token for the 'factory' keyword.
   * @return the token for the 'factory' keyword
   */
  Token get factoryKeyword => _factoryKeyword;
  /**
   * Return the initializers associated with the constructor.
   * @return the initializers associated with the constructor
   */
  NodeList<ConstructorInitializer> get initializers => _initializers;
  /**
   * Return the name of the constructor, or {@code null} if the constructor being declared is
   * unnamed.
   * @return the name of the constructor
   */
  SimpleIdentifier get name => _name;
  /**
   * Return the parameters associated with the constructor.
   * @return the parameters associated with the constructor
   */
  FormalParameterList get parameters => _parameters;
  /**
   * Return the token for the period before the constructor name, or {@code null} if the constructor
   * being declared is unnamed.
   * @return the token for the period before the constructor name
   */
  Token get period => _period;
  /**
   * Return the name of the constructor to which this constructor will be redirected, or{@code null} if this is not a redirecting factory constructor.
   * @return the name of the constructor to which this constructor will be redirected
   */
  ConstructorName get redirectedConstructor => _redirectedConstructor;
  /**
   * Return the type of object being created. This can be different than the type in which the
   * constructor is being declared if the constructor is the implementation of a factory
   * constructor.
   * @return the type of object being created
   */
  Identifier get returnType => _returnType;
  /**
   * Return the token for the separator (colon or equals) before the initializers, or {@code null}if there are no initializers.
   * @return the token for the separator (colon or equals) before the initializers
   */
  Token get separator => _separator;
  /**
   * Set the body of the constructor to the given function body.
   * @param functionBody the body of the constructor
   */
  void set body3(FunctionBody functionBody) {
    _body = becomeParentOf(functionBody);
  }
  /**
   * Set the token for the 'const' keyword to the given token.
   * @param constKeyword the token for the 'const' keyword
   */
  void set constKeyword2(Token constKeyword) {
    this._constKeyword = constKeyword;
  }
  /**
   * Set the element associated with this constructor to the given element.
   * @param element the element associated with this constructor
   */
  void set element5(ConstructorElement element) {
    this._element = element;
  }
  /**
   * Set the token for the 'external' keyword to the given token.
   * @param externalKeyword the token for the 'external' keyword
   */
  void set externalKeyword2(Token externalKeyword) {
    this._externalKeyword = externalKeyword;
  }
  /**
   * Set the token for the 'factory' keyword to the given token.
   * @param factoryKeyword the token for the 'factory' keyword
   */
  void set factoryKeyword2(Token factoryKeyword) {
    this._factoryKeyword = factoryKeyword;
  }
  /**
   * Set the name of the constructor to the given identifier.
   * @param identifier the name of the constructor
   */
  void set name5(SimpleIdentifier identifier) {
    _name = becomeParentOf(identifier);
  }
  /**
   * Set the parameters associated with the constructor to the given list of parameters.
   * @param parameters the parameters associated with the constructor
   */
  void set parameters2(FormalParameterList parameters) {
    this._parameters = becomeParentOf(parameters);
  }
  /**
   * Set the token for the period before the constructor name to the given token.
   * @param period the token for the period before the constructor name
   */
  void set period3(Token period) {
    this._period = period;
  }
  /**
   * Set the name of the constructor to which this constructor will be redirected to the given
   * constructor name.
   * @param redirectedConstructor the name of the constructor to which this constructor will be
   * redirected
   */
  void set redirectedConstructor2(ConstructorName redirectedConstructor) {
    this._redirectedConstructor = becomeParentOf(redirectedConstructor);
  }
  /**
   * Set the type of object being created to the given type name.
   * @param typeName the type of object being created
   */
  void set returnType2(Identifier typeName) {
    _returnType = becomeParentOf(typeName);
  }
  /**
   * Set the token for the separator (colon or equals) before the initializers to the given token.
   * @param separator the token for the separator (colon or equals) before the initializers
   */
  void set separator2(Token separator) {
    this._separator = separator;
  }
  void visitChildren(ASTVisitor<Object> visitor) {
    super.visitChildren(visitor);
    safelyVisitChild(_returnType, visitor);
    safelyVisitChild(_name, visitor);
    safelyVisitChild(_parameters, visitor);
    _initializers.accept(visitor);
    safelyVisitChild(_body, visitor);
  }
  Token get firstTokenAfterCommentAndMetadata {
    Token leftMost2 = leftMost([_externalKeyword, _constKeyword, _factoryKeyword]);
    if (leftMost2 != null) {
      return leftMost2;
    }
    return _returnType.beginToken;
  }
  /**
   * Return the left-most of the given tokens, or {@code null} if there are no tokens given or if
   * all of the given tokens are {@code null}.
   * @param tokens the tokens being compared to find the left-most token
   * @return the left-most of the given tokens
   */
  Token leftMost(List<Token> tokens) {
    Token leftMost = null;
    int offset = 2147483647;
    for (Token token in tokens) {
      if (token != null && token.offset < offset) {
        leftMost = token;
      }
    }
    return leftMost;
  }
}
/**
 * Instances of the class {@code ConstructorFieldInitializer} represent the initialization of a
 * field within a constructor's initialization list.
 * <pre>
 * fieldInitializer ::=
 * ('this' '.')? {@link SimpleIdentifier fieldName} '=' {@link Expression conditionalExpression cascadeSection*}</pre>
 */
class ConstructorFieldInitializer extends ConstructorInitializer {
  /**
   * The token for the 'this' keyword, or {@code null} if there is no 'this' keyword.
   */
  Token _keyword;
  /**
   * The token for the period after the 'this' keyword, or {@code null} if there is no 'this'
   * keyword.
   */
  Token _period;
  /**
   * The name of the field being initialized.
   */
  SimpleIdentifier _fieldName;
  /**
   * The token for the equal sign between the field name and the expression.
   */
  Token _equals;
  /**
   * The expression computing the value to which the field will be initialized.
   */
  Expression _expression;
  /**
   * Initialize a newly created field initializer to initialize the field with the given name to the
   * value of the given expression.
   * @param keyword the token for the 'this' keyword
   * @param period the token for the period after the 'this' keyword
   * @param fieldName the name of the field being initialized
   * @param equals the token for the equal sign between the field name and the expression
   * @param expression the expression computing the value to which the field will be initialized
   */
  ConstructorFieldInitializer(Token keyword, Token period, SimpleIdentifier fieldName, Token equals, Expression expression) {
    this._keyword = keyword;
    this._period = period;
    this._fieldName = becomeParentOf(fieldName);
    this._equals = equals;
    this._expression = becomeParentOf(expression);
  }
  accept(ASTVisitor visitor) => visitor.visitConstructorFieldInitializer(this);
  Token get beginToken {
    if (_keyword != null) {
      return _keyword;
    }
    return _fieldName.beginToken;
  }
  Token get endToken => _expression.endToken;
  /**
   * Return the token for the equal sign between the field name and the expression.
   * @return the token for the equal sign between the field name and the expression
   */
  Token get equals => _equals;
  /**
   * Return the expression computing the value to which the field will be initialized.
   * @return the expression computing the value to which the field will be initialized
   */
  Expression get expression => _expression;
  /**
   * Return the name of the field being initialized.
   * @return the name of the field being initialized
   */
  SimpleIdentifier get fieldName => _fieldName;
  /**
   * Return the token for the 'this' keyword, or {@code null} if there is no 'this' keyword.
   * @return the token for the 'this' keyword
   */
  Token get keyword => _keyword;
  /**
   * Return the token for the period after the 'this' keyword, or {@code null} if there is no 'this'
   * keyword.
   * @return the token for the period after the 'this' keyword
   */
  Token get period => _period;
  /**
   * Set the token for the equal sign between the field name and the expression to the given token.
   * @param equals the token for the equal sign between the field name and the expression
   */
  void set equals5(Token equals) {
    this._equals = equals;
  }
  /**
   * Set the expression computing the value to which the field will be initialized to the given
   * expression.
   * @param expression the expression computing the value to which the field will be initialized
   */
  void set expression3(Expression expression) {
    this._expression = becomeParentOf(expression);
  }
  /**
   * Set the name of the field being initialized to the given identifier.
   * @param identifier the name of the field being initialized
   */
  void set fieldName2(SimpleIdentifier identifier) {
    _fieldName = becomeParentOf(identifier);
  }
  /**
   * Set the token for the 'this' keyword to the given token.
   * @param keyword the token for the 'this' keyword
   */
  void set keyword6(Token keyword) {
    this._keyword = keyword;
  }
  /**
   * Set the token for the period after the 'this' keyword to the given token.
   * @param period the token for the period after the 'this' keyword
   */
  void set period4(Token period) {
    this._period = period;
  }
  void visitChildren(ASTVisitor<Object> visitor) {
    safelyVisitChild(_fieldName, visitor);
    safelyVisitChild(_expression, visitor);
  }
}
/**
 * Instances of the class {@code ConstructorInitializer} defines the behavior of nodes that can
 * occur in the initializer list of a constructor declaration.
 * <pre>
 * constructorInitializer ::={@link SuperConstructorInvocation superInvocation}| {@link ConstructorFieldInitializer fieldInitializer}</pre>
 */
abstract class ConstructorInitializer extends ASTNode {
}
/**
 * Instances of the class {@code ConstructorName} represent the name of the constructor.
 * <pre>
 * constructorName:
 * type ('.' identifier)?
 * </pre>
 */
class ConstructorName extends ASTNode {
  /**
   * The name of the type defining the constructor.
   */
  TypeName _type;
  /**
   * The token for the period before the constructor name, or {@code null} if the specified
   * constructor is the unnamed constructor.
   */
  Token _period;
  /**
   * The name of the constructor, or {@code null} if the specified constructor is the unnamed
   * constructor.
   */
  SimpleIdentifier _name;
  /**
   * The element associated with this constructor name, or {@code null} if the AST structure has not
   * been resolved or if this constructor name could not be resolved.
   */
  ConstructorElement _element;
  /**
   * Initialize a newly created constructor name.
   * @param type the name of the type defining the constructor
   * @param period the token for the period before the constructor name
   * @param name the name of the constructor
   */
  ConstructorName(TypeName type, Token period, SimpleIdentifier name) {
    this._type = becomeParentOf(type);
    this._period = period;
    this._name = becomeParentOf(name);
  }
  accept(ASTVisitor visitor) => visitor.visitConstructorName(this);
  Token get beginToken => _type.beginToken;
  /**
   * Return the element associated with this constructor name, or {@code null} if the AST structure
   * has not been resolved or if this constructor name could not be resolved.
   * @return the element associated with this constructor name
   */
  ConstructorElement get element => _element;
  Token get endToken {
    if (_name != null) {
      return _name.endToken;
    }
    return _type.endToken;
  }
  /**
   * Return the name of the constructor, or {@code null} if the specified constructor is the unnamed
   * constructor.
   * @return the name of the constructor
   */
  SimpleIdentifier get name => _name;
  /**
   * Return the token for the period before the constructor name, or {@code null} if the specified
   * constructor is the unnamed constructor.
   * @return the token for the period before the constructor name
   */
  Token get period => _period;
  /**
   * Return the name of the type defining the constructor.
   * @return the name of the type defining the constructor
   */
  TypeName get type => _type;
  /**
   * Set the element associated with this constructor name to the given element.
   * @param element the element associated with this constructor name
   */
  void set element6(ConstructorElement element) {
    this._element = element;
  }
  /**
   * Set the name of the constructor to the given name.
   * @param name the name of the constructor
   */
  void set name6(SimpleIdentifier name) {
    this._name = becomeParentOf(name);
  }
  /**
   * Return the token for the period before the constructor name to the given token.
   * @param period the token for the period before the constructor name
   */
  void set period5(Token period) {
    this._period = period;
  }
  /**
   * Set the name of the type defining the constructor to the given type name.
   * @param type the name of the type defining the constructor
   */
  void set type3(TypeName type) {
    this._type = becomeParentOf(type);
  }
  void visitChildren(ASTVisitor<Object> visitor) {
    safelyVisitChild(_type, visitor);
    safelyVisitChild(_name, visitor);
  }
}
/**
 * Instances of the class {@code ContinueStatement} represent a continue statement.
 * <pre>
 * continueStatement ::=
 * 'continue' {@link SimpleIdentifier label}? ';'
 * </pre>
 */
class ContinueStatement extends Statement {
  /**
   * The token representing the 'continue' keyword.
   */
  Token _keyword;
  /**
   * The label associated with the statement, or {@code null} if there is no label.
   */
  SimpleIdentifier _label;
  /**
   * The semicolon terminating the statement.
   */
  Token _semicolon;
  /**
   * Initialize a newly created continue statement.
   * @param keyword the token representing the 'continue' keyword
   * @param label the label associated with the statement
   * @param semicolon the semicolon terminating the statement
   */
  ContinueStatement(Token keyword, SimpleIdentifier label, Token semicolon) {
    this._keyword = keyword;
    this._label = becomeParentOf(label);
    this._semicolon = semicolon;
  }
  accept(ASTVisitor visitor) => visitor.visitContinueStatement(this);
  Token get beginToken => _keyword;
  Token get endToken => _semicolon;
  /**
   * Return the token representing the 'continue' keyword.
   * @return the token representing the 'continue' keyword
   */
  Token get keyword => _keyword;
  /**
   * Return the label associated with the statement, or {@code null} if there is no label.
   * @return the label associated with the statement
   */
  SimpleIdentifier get label => _label;
  /**
   * Return the semicolon terminating the statement.
   * @return the semicolon terminating the statement
   */
  Token get semicolon => _semicolon;
  /**
   * Set the token representing the 'continue' keyword to the given token.
   * @param keyword the token representing the 'continue' keyword
   */
  void set keyword7(Token keyword) {
    this._keyword = keyword;
  }
  /**
   * Set the label associated with the statement to the given label.
   * @param identifier the label associated with the statement
   */
  void set label3(SimpleIdentifier identifier) {
    _label = becomeParentOf(identifier);
  }
  /**
   * Set the semicolon terminating the statement to the given token.
   * @param semicolon the semicolon terminating the statement
   */
  void set semicolon4(Token semicolon) {
    this._semicolon = semicolon;
  }
  void visitChildren(ASTVisitor<Object> visitor) {
    safelyVisitChild(_label, visitor);
  }
}
/**
 * The abstract class {@code Declaration} defines the behavior common to nodes that represent the
 * declaration of a name. Each declared name is visible within a name scope.
 */
abstract class Declaration extends AnnotatedNode {
  /**
   * Initialize a newly created declaration.
   * @param comment the documentation comment associated with this declaration
   * @param metadata the annotations associated with this declaration
   */
  Declaration(Comment comment, List<Annotation> metadata) : super(comment, metadata) {
  }
}
/**
 * Instances of the class {@code DefaultFormalParameter} represent a formal parameter with a default
 * value. There are two kinds of parameters that are both represented by this class: named formal
 * parameters and positional formal parameters.
 * <pre>
 * defaultFormalParameter ::={@link NormalFormalParameter normalFormalParameter} ('=' {@link Expression defaultValue})?
 * defaultNamedParameter ::={@link NormalFormalParameter normalFormalParameter} (':' {@link Expression defaultValue})?
 * </pre>
 */
class DefaultFormalParameter extends FormalParameter {
  /**
   * The formal parameter with which the default value is associated.
   */
  NormalFormalParameter _parameter;
  /**
   * The kind of this parameter.
   */
  ParameterKind _kind;
  /**
   * The token separating the parameter from the default value, or {@code null} if there is no
   * default value.
   */
  Token _separator;
  /**
   * The expression computing the default value for the parameter, or {@code null} if there is no
   * default value.
   */
  Expression _defaultValue;
  /**
   * Initialize a newly created default formal parameter.
   * @param parameter the formal parameter with which the default value is associated
   * @param kind the kind of this parameter
   * @param separator the token separating the parameter from the default value
   * @param defaultValue the expression computing the default value for the parameter
   */
  DefaultFormalParameter(NormalFormalParameter parameter, ParameterKind kind, Token separator, Expression defaultValue) {
    this._parameter = becomeParentOf(parameter);
    this._kind = kind;
    this._separator = separator;
    this._defaultValue = becomeParentOf(defaultValue);
  }
  accept(ASTVisitor visitor) => visitor.visitDefaultFormalParameter(this);
  Token get beginToken => _parameter.beginToken;
  /**
   * Return the expression computing the default value for the parameter, or {@code null} if there
   * is no default value.
   * @return the expression computing the default value for the parameter
   */
  Expression get defaultValue => _defaultValue;
  Token get endToken {
    if (_defaultValue != null) {
      return _defaultValue.endToken;
    }
    return _parameter.endToken;
  }
  SimpleIdentifier get identifier => _parameter.identifier;
  ParameterKind get kind => _kind;
  /**
   * Return the formal parameter with which the default value is associated.
   * @return the formal parameter with which the default value is associated
   */
  NormalFormalParameter get parameter => _parameter;
  /**
   * Return the token separating the parameter from the default value, or {@code null} if there is
   * no default value.
   * @return the token separating the parameter from the default value
   */
  Token get separator => _separator;
  /**
   * Return {@code true} if this parameter is a const parameter.
   * @return {@code true} if this parameter is a const parameter
   */
  bool isConst() => _parameter != null && _parameter.isConst();
  /**
   * Return {@code true} if this parameter is a final parameter.
   * @return {@code true} if this parameter is a final parameter
   */
  bool isFinal() => _parameter != null && _parameter.isFinal();
  /**
   * Set the expression computing the default value for the parameter to the given expression.
   * @param expression the expression computing the default value for the parameter
   */
  void set defaultValue2(Expression expression) {
    _defaultValue = becomeParentOf(expression);
  }
  /**
   * Set the kind of this parameter to the given kind.
   * @param kind the kind of this parameter
   */
  void set kind2(ParameterKind kind) {
    this._kind = kind;
  }
  /**
   * Set the formal parameter with which the default value is associated to the given parameter.
   * @param formalParameter the formal parameter with which the default value is associated
   */
  void set parameter2(NormalFormalParameter formalParameter) {
    _parameter = becomeParentOf(formalParameter);
  }
  /**
   * Set the token separating the parameter from the default value to the given token.
   * @param separator the token separating the parameter from the default value
   */
  void set separator3(Token separator) {
    this._separator = separator;
  }
  void visitChildren(ASTVisitor<Object> visitor) {
    safelyVisitChild(_parameter, visitor);
    safelyVisitChild(_defaultValue, visitor);
  }
}
/**
 * The abstract class {@code Directive} defines the behavior common to nodes that represent a
 * directive.
 * <pre>
 * directive ::={@link ExportDirective exportDirective}| {@link ImportDirective importDirective}| {@link LibraryDirective libraryDirective}| {@link PartDirective partDirective}| {@link PartOfDirective partOfDirective}</pre>
 */
abstract class Directive extends AnnotatedNode {
  /**
   * The element associated with this directive, or {@code null} if the AST structure has not been
   * resolved or if this directive could not be resolved.
   */
  Element _element;
  /**
   * Initialize a newly create directive.
   * @param comment the documentation comment associated with this directive
   * @param metadata the annotations associated with the directive
   */
  Directive(Comment comment, List<Annotation> metadata) : super(comment, metadata) {
  }
  /**
   * Return the element associated with this directive, or {@code null} if the AST structure has not
   * been resolved or if this directive could not be resolved. Examples of the latter case include a
   * directive that contains an invalid URL or a URL that does not exist.
   * @return the element associated with this directive
   */
  Element get element => _element;
  /**
   * Return the token representing the keyword that introduces this directive ('import', 'export',
   * 'library' or 'part').
   * @return the token representing the keyword that introduces this directive
   */
  Token get keyword;
  /**
   * Set the element associated with this directive to the given element.
   * @param element the element associated with this directive
   */
  void set element7(Element element) {
    this._element = element;
  }
}
/**
 * Instances of the class {@code DoStatement} represent a do statement.
 * <pre>
 * doStatement ::=
 * 'do' {@link Statement body} 'while' '(' {@link Expression condition} ')' ';'
 * </pre>
 */
class DoStatement extends Statement {
  /**
   * The token representing the 'do' keyword.
   */
  Token _doKeyword;
  /**
   * The body of the loop.
   */
  Statement _body;
  /**
   * The token representing the 'while' keyword.
   */
  Token _whileKeyword;
  /**
   * The left parenthesis.
   */
  Token _leftParenthesis;
  /**
   * The condition that determines when the loop will terminate.
   */
  Expression _condition;
  /**
   * The right parenthesis.
   */
  Token _rightParenthesis;
  /**
   * The semicolon terminating the statement.
   */
  Token _semicolon;
  /**
   * Initialize a newly created do loop.
   * @param doKeyword the token representing the 'do' keyword
   * @param body the body of the loop
   * @param whileKeyword the token representing the 'while' keyword
   * @param leftParenthesis the left parenthesis
   * @param condition the condition that determines when the loop will terminate
   * @param rightParenthesis the right parenthesis
   * @param semicolon the semicolon terminating the statement
   */
  DoStatement(Token doKeyword, Statement body, Token whileKeyword, Token leftParenthesis, Expression condition, Token rightParenthesis, Token semicolon) {
    this._doKeyword = doKeyword;
    this._body = becomeParentOf(body);
    this._whileKeyword = whileKeyword;
    this._leftParenthesis = leftParenthesis;
    this._condition = becomeParentOf(condition);
    this._rightParenthesis = rightParenthesis;
    this._semicolon = semicolon;
  }
  accept(ASTVisitor visitor) => visitor.visitDoStatement(this);
  Token get beginToken => _doKeyword;
  /**
   * Return the body of the loop.
   * @return the body of the loop
   */
  Statement get body => _body;
  /**
   * Return the condition that determines when the loop will terminate.
   * @return the condition that determines when the loop will terminate
   */
  Expression get condition => _condition;
  /**
   * Return the token representing the 'do' keyword.
   * @return the token representing the 'do' keyword
   */
  Token get doKeyword => _doKeyword;
  Token get endToken => _semicolon;
  /**
   * Return the left parenthesis.
   * @return the left parenthesis
   */
  Token get leftParenthesis => _leftParenthesis;
  /**
   * Return the right parenthesis.
   * @return the right parenthesis
   */
  Token get rightParenthesis => _rightParenthesis;
  /**
   * Return the semicolon terminating the statement.
   * @return the semicolon terminating the statement
   */
  Token get semicolon => _semicolon;
  /**
   * Return the token representing the 'while' keyword.
   * @return the token representing the 'while' keyword
   */
  Token get whileKeyword => _whileKeyword;
  /**
   * Set the body of the loop to the given statement.
   * @param statement the body of the loop
   */
  void set body4(Statement statement) {
    _body = becomeParentOf(statement);
  }
  /**
   * Set the condition that determines when the loop will terminate to the given expression.
   * @param expression the condition that determines when the loop will terminate
   */
  void set condition4(Expression expression) {
    _condition = becomeParentOf(expression);
  }
  /**
   * Set the token representing the 'do' keyword to the given token.
   * @param doKeyword the token representing the 'do' keyword
   */
  void set doKeyword2(Token doKeyword) {
    this._doKeyword = doKeyword;
  }
  /**
   * Set the left parenthesis to the given token.
   * @param parenthesis the left parenthesis
   */
  void set leftParenthesis5(Token parenthesis) {
    _leftParenthesis = parenthesis;
  }
  /**
   * Set the right parenthesis to the given token.
   * @param parenthesis the right parenthesis
   */
  void set rightParenthesis5(Token parenthesis) {
    _rightParenthesis = parenthesis;
  }
  /**
   * Set the semicolon terminating the statement to the given token.
   * @param semicolon the semicolon terminating the statement
   */
  void set semicolon5(Token semicolon) {
    this._semicolon = semicolon;
  }
  /**
   * Set the token representing the 'while' keyword to the given token.
   * @param whileKeyword the token representing the 'while' keyword
   */
  void set whileKeyword2(Token whileKeyword) {
    this._whileKeyword = whileKeyword;
  }
  void visitChildren(ASTVisitor<Object> visitor) {
    safelyVisitChild(_body, visitor);
    safelyVisitChild(_condition, visitor);
  }
}
/**
 * Instances of the class {@code DoubleLiteral} represent a floating point literal expression.
 * <pre>
 * doubleLiteral ::=
 * decimalDigit+ ('.' decimalDigit*)? exponent?
 * | '.' decimalDigit+ exponent?
 * exponent ::=
 * ('e' | 'E') ('+' | '-')? decimalDigit+
 * </pre>
 */
class DoubleLiteral extends Literal {
  /**
   * The token representing the literal.
   */
  Token _literal;
  /**
   * The value of the literal.
   */
  double _value = 0.0;
  /**
   * Initialize a newly created floating point literal.
   * @param literal the token representing the literal
   * @param value the value of the literal
   */
  DoubleLiteral(Token literal, double value) {
    this._literal = literal;
    this._value = value;
  }
  accept(ASTVisitor visitor) => visitor.visitDoubleLiteral(this);
  Token get beginToken => _literal;
  Token get endToken => _literal;
  /**
   * Return the token representing the literal.
   * @return the token representing the literal
   */
  Token get literal => _literal;
  /**
   * Return the value of the literal.
   * @return the value of the literal
   */
  double get value => _value;
  /**
   * Set the token representing the literal to the given token.
   * @param literal the token representing the literal
   */
  void set literal3(Token literal) {
    this._literal = literal;
  }
  /**
   * Set the value of the literal to the given value.
   * @param value the value of the literal
   */
  void set value5(double value) {
    this._value = value;
  }
  void visitChildren(ASTVisitor<Object> visitor) {
  }
}
/**
 * Instances of the class {@code EmptyFunctionBody} represent an empty function body, which can only
 * appear in constructors or abstract methods.
 * <pre>
 * emptyFunctionBody ::=
 * ';'
 * </pre>
 */
class EmptyFunctionBody extends FunctionBody {
  /**
   * The token representing the semicolon that marks the end of the function body.
   */
  Token _semicolon;
  /**
   * Initialize a newly created function body.
   * @param semicolon the token representing the semicolon that marks the end of the function body
   */
  EmptyFunctionBody(Token semicolon) {
    this._semicolon = semicolon;
  }
  accept(ASTVisitor visitor) => visitor.visitEmptyFunctionBody(this);
  Token get beginToken => _semicolon;
  Token get endToken => _semicolon;
  /**
   * Return the token representing the semicolon that marks the end of the function body.
   * @return the token representing the semicolon that marks the end of the function body
   */
  Token get semicolon => _semicolon;
  /**
   * Set the token representing the semicolon that marks the end of the function body to the given
   * token.
   * @param semicolon the token representing the semicolon that marks the end of the function body
   */
  void set semicolon6(Token semicolon) {
    this._semicolon = semicolon;
  }
  void visitChildren(ASTVisitor<Object> visitor) {
  }
}
/**
 * Instances of the class {@code EmptyStatement} represent an empty statement.
 * <pre>
 * emptyStatement ::=
 * ';'
 * </pre>
 */
class EmptyStatement extends Statement {
  /**
   * The semicolon terminating the statement.
   */
  Token _semicolon;
  /**
   * Initialize a newly created empty statement.
   * @param semicolon the semicolon terminating the statement
   */
  EmptyStatement(Token semicolon) {
    this._semicolon = semicolon;
  }
  accept(ASTVisitor visitor) => visitor.visitEmptyStatement(this);
  Token get beginToken => _semicolon;
  Token get endToken => _semicolon;
  /**
   * Return the semicolon terminating the statement.
   * @return the semicolon terminating the statement
   */
  Token get semicolon => _semicolon;
  /**
   * Set the semicolon terminating the statement to the given token.
   * @param semicolon the semicolon terminating the statement
   */
  void set semicolon7(Token semicolon) {
    this._semicolon = semicolon;
  }
  void visitChildren(ASTVisitor<Object> visitor) {
  }
}
/**
 * Instances of the class {@code ExportDirective} represent an export directive.
 * <pre>
 * exportDirective ::={@link Annotation metadata} 'export' {@link StringLiteral libraryUri} {@link Combinator combinator}* ';'
 * </pre>
 */
class ExportDirective extends NamespaceDirective {
  /**
   * Initialize a newly created export directive.
   * @param comment the documentation comment associated with this directive
   * @param metadata the annotations associated with the directive
   * @param keyword the token representing the 'export' keyword
   * @param libraryUri the URI of the library being exported
   * @param combinators the combinators used to control which names are exported
   * @param semicolon the semicolon terminating the directive
   */
  ExportDirective(Comment comment, List<Annotation> metadata, Token keyword, StringLiteral libraryUri, List<Combinator> combinators, Token semicolon) : super(comment, metadata, keyword, libraryUri, combinators, semicolon) {
  }
  accept(ASTVisitor visitor) => visitor.visitExportDirective(this);
  void visitChildren(ASTVisitor<Object> visitor) {
    super.visitChildren(visitor);
    safelyVisitChild(libraryUri, visitor);
    combinators.accept(visitor);
  }
}
/**
 * Instances of the class {@code Expression} defines the behavior common to nodes that represent an
 * expression.
 * <pre>
 * expression ::={@link AssignmentExpression assignmentExpression}| {@link ConditionalExpression conditionalExpression} cascadeSection
 * | {@link ThrowExpression throwExpression}</pre>
 */
abstract class Expression extends ASTNode {
  /**
   * The static type of this expression, or {@code null} if the AST structure has not been resolved.
   */
  Type2 _staticType;
  /**
   * The propagated type of this expression, or {@code null} if type propagation has not been
   * performed on the AST structure.
   */
  Type2 _propagatedType;
  /**
   * Return the propagated type of this expression, or {@code null} if type propagation has not been
   * performed on the AST structure.
   * @return the propagated type of this expression
   */
  Type2 get propagatedType => _propagatedType;
  /**
   * Return the static type of this expression, or {@code null} if the AST structure has not been
   * resolved.
   * @return the static type of this expression
   */
  Type2 get staticType => _staticType;
  /**
   * Return {@code true} if this expression is syntactically valid for the LHS of an{@link AssignmentExpression assignment expression}.
   * @return {@code true} if this expression matches the {@code assignableExpression} production
   */
  bool isAssignable() => false;
  /**
   * Set the propagated type of this expression to the given type.
   * @param propagatedType the propagated type of this expression
   */
  void set propagatedType2(Type2 propagatedType) {
    this._propagatedType = propagatedType;
  }
  /**
   * Set the static type of this expression to the given type.
   * @param staticType the static type of this expression
   */
  void set staticType2(Type2 staticType) {
    this._staticType = staticType;
  }
}
/**
 * Instances of the class {@code ExpressionFunctionBody} represent a function body consisting of a
 * single expression.
 * <pre>
 * expressionFunctionBody ::=
 * '=>' {@link Expression expression} ';'
 * </pre>
 */
class ExpressionFunctionBody extends FunctionBody {
  /**
   * The token introducing the expression that represents the body of the function.
   */
  Token _functionDefinition;
  /**
   * The expression representing the body of the function.
   */
  Expression _expression;
  /**
   * The semicolon terminating the statement.
   */
  Token _semicolon;
  /**
   * Initialize a newly created function body consisting of a block of statements.
   * @param functionDefinition the token introducing the expression that represents the body of the
   * function
   * @param expression the expression representing the body of the function
   * @param semicolon the semicolon terminating the statement
   */
  ExpressionFunctionBody(Token functionDefinition, Expression expression, Token semicolon) {
    this._functionDefinition = functionDefinition;
    this._expression = becomeParentOf(expression);
    this._semicolon = semicolon;
  }
  accept(ASTVisitor visitor) => visitor.visitExpressionFunctionBody(this);
  Token get beginToken => _functionDefinition;
  Token get endToken {
    if (_semicolon != null) {
      return _semicolon;
    }
    return _expression.endToken;
  }
  /**
   * Return the expression representing the body of the function.
   * @return the expression representing the body of the function
   */
  Expression get expression => _expression;
  /**
   * Return the token introducing the expression that represents the body of the function.
   * @return the function definition token
   */
  Token get functionDefinition => _functionDefinition;
  /**
   * Return the semicolon terminating the statement.
   * @return the semicolon terminating the statement
   */
  Token get semicolon => _semicolon;
  /**
   * Set the expression representing the body of the function to the given expression.
   * @param expression the expression representing the body of the function
   */
  void set expression4(Expression expression) {
    this._expression = becomeParentOf(expression);
  }
  /**
   * Set the token introducing the expression that represents the body of the function to the given
   * token.
   * @param functionDefinition the function definition token
   */
  void set functionDefinition2(Token functionDefinition) {
    this._functionDefinition = functionDefinition;
  }
  /**
   * Set the semicolon terminating the statement to the given token.
   * @param semicolon the semicolon terminating the statement
   */
  void set semicolon8(Token semicolon) {
    this._semicolon = semicolon;
  }
  void visitChildren(ASTVisitor<Object> visitor) {
    safelyVisitChild(_expression, visitor);
  }
}
/**
 * Instances of the class {@code ExpressionStatement} wrap an expression as a statement.
 * <pre>
 * expressionStatement ::={@link Expression expression}? ';'
 * </pre>
 */
class ExpressionStatement extends Statement {
  /**
   * The expression that comprises the statement.
   */
  Expression _expression;
  /**
   * The semicolon terminating the statement, or {@code null} if the expression is a function
   * expression and isn't followed by a semicolon.
   */
  Token _semicolon;
  /**
   * Initialize a newly created expression statement.
   * @param expression the expression that comprises the statement
   * @param semicolon the semicolon terminating the statement
   */
  ExpressionStatement(Expression expression, Token semicolon) {
    this._expression = becomeParentOf(expression);
    this._semicolon = semicolon;
  }
  accept(ASTVisitor visitor) => visitor.visitExpressionStatement(this);
  Token get beginToken => _expression.beginToken;
  Token get endToken {
    if (_semicolon != null) {
      return _semicolon;
    }
    return _expression.endToken;
  }
  /**
   * Return the expression that comprises the statement.
   * @return the expression that comprises the statement
   */
  Expression get expression => _expression;
  /**
   * Return the semicolon terminating the statement.
   * @return the semicolon terminating the statement
   */
  Token get semicolon => _semicolon;
  bool isSynthetic() => _expression.isSynthetic() && _semicolon.isSynthetic();
  /**
   * Set the expression that comprises the statement to the given expression.
   * @param expression the expression that comprises the statement
   */
  void set expression5(Expression expression) {
    this._expression = becomeParentOf(expression);
  }
  /**
   * Set the semicolon terminating the statement to the given token.
   * @param semicolon the semicolon terminating the statement
   */
  void set semicolon9(Token semicolon) {
    this._semicolon = semicolon;
  }
  void visitChildren(ASTVisitor<Object> visitor) {
    safelyVisitChild(_expression, visitor);
  }
}
/**
 * Instances of the class {@code ExtendsClause} represent the "extends" clause in a class
 * declaration.
 * <pre>
 * extendsClause ::=
 * 'extends' {@link TypeName superclass}</pre>
 */
class ExtendsClause extends ASTNode {
  /**
   * The token representing the 'extends' keyword.
   */
  Token _keyword;
  /**
   * The name of the class that is being extended.
   */
  TypeName _superclass;
  /**
   * Initialize a newly created extends clause.
   * @param keyword the token representing the 'extends' keyword
   * @param superclass the name of the class that is being extended
   */
  ExtendsClause(Token keyword, TypeName superclass) {
    this._keyword = keyword;
    this._superclass = becomeParentOf(superclass);
  }
  accept(ASTVisitor visitor) => visitor.visitExtendsClause(this);
  Token get beginToken => _keyword;
  Token get endToken => _superclass.endToken;
  /**
   * Return the token representing the 'extends' keyword.
   * @return the token representing the 'extends' keyword
   */
  Token get keyword => _keyword;
  /**
   * Return the name of the class that is being extended.
   * @return the name of the class that is being extended
   */
  TypeName get superclass => _superclass;
  /**
   * Set the token representing the 'extends' keyword to the given token.
   * @param keyword the token representing the 'extends' keyword
   */
  void set keyword8(Token keyword) {
    this._keyword = keyword;
  }
  /**
   * Set the name of the class that is being extended to the given name.
   * @param name the name of the class that is being extended
   */
  void set superclass3(TypeName name) {
    _superclass = becomeParentOf(name);
  }
  void visitChildren(ASTVisitor<Object> visitor) {
    safelyVisitChild(_superclass, visitor);
  }
}
/**
 * Instances of the class {@code FieldDeclaration} represent the declaration of one or more fields
 * of the same type.
 * <pre>
 * fieldDeclaration ::=
 * 'static'? {@link VariableDeclarationList fieldList} ';'
 * </pre>
 */
class FieldDeclaration extends ClassMember {
  /**
   * The token representing the 'static' keyword, or {@code null} if the fields are not static.
   */
  Token _keyword;
  /**
   * The fields being declared.
   */
  VariableDeclarationList _fieldList;
  /**
   * The semicolon terminating the declaration.
   */
  Token _semicolon;
  /**
   * Initialize a newly created field declaration.
   * @param comment the documentation comment associated with this field
   * @param metadata the annotations associated with this field
   * @param keyword the token representing the 'static' keyword
   * @param fieldList the fields being declared
   * @param semicolon the semicolon terminating the declaration
   */
  FieldDeclaration(Comment comment, List<Annotation> metadata, Token keyword, VariableDeclarationList fieldList, Token semicolon) : super(comment, metadata) {
    this._keyword = keyword;
    this._fieldList = becomeParentOf(fieldList);
    this._semicolon = semicolon;
  }
  accept(ASTVisitor visitor) => visitor.visitFieldDeclaration(this);
  Token get endToken => _semicolon;
  /**
   * Return the fields being declared.
   * @return the fields being declared
   */
  VariableDeclarationList get fields => _fieldList;
  /**
   * Return the token representing the 'static' keyword, or {@code null} if the fields are not
   * static.
   * @return the token representing the 'static' keyword
   */
  Token get keyword => _keyword;
  /**
   * Return the semicolon terminating the declaration.
   * @return the semicolon terminating the declaration
   */
  Token get semicolon => _semicolon;
  /**
   * Set the fields being declared to the given list of variables.
   * @param fieldList the fields being declared
   */
  void set fields2(VariableDeclarationList fieldList) {
    fieldList = becomeParentOf(fieldList);
  }
  /**
   * Set the token representing the 'static' keyword to the given token.
   * @param keyword the token representing the 'static' keyword
   */
  void set keyword9(Token keyword) {
    this._keyword = keyword;
  }
  /**
   * Set the semicolon terminating the declaration to the given token.
   * @param semicolon the semicolon terminating the declaration
   */
  void set semicolon10(Token semicolon) {
    this._semicolon = semicolon;
  }
  void visitChildren(ASTVisitor<Object> visitor) {
    super.visitChildren(visitor);
    safelyVisitChild(_fieldList, visitor);
  }
  Token get firstTokenAfterCommentAndMetadata {
    if (_keyword != null) {
      return _keyword;
    }
    return _fieldList.beginToken;
  }
}
/**
 * Instances of the class {@code FieldFormalParameter} represent a field formal parameter.
 * <pre>
 * fieldFormalParameter ::=
 * ('final' {@link TypeName type} | 'const' {@link TypeName type} | 'var' | {@link TypeName type})? 'this' '.' {@link SimpleIdentifier identifier}</pre>
 */
class FieldFormalParameter extends NormalFormalParameter {
  /**
   * The token representing either the 'final', 'const' or 'var' keyword, or {@code null} if no
   * keyword was used.
   */
  Token _keyword;
  /**
   * The name of the declared type of the parameter, or {@code null} if the parameter does not have
   * a declared type.
   */
  TypeName _type;
  /**
   * The token representing the 'this' keyword.
   */
  Token _thisToken;
  /**
   * The token representing the period.
   */
  Token _period;
  /**
   * Initialize a newly created formal parameter.
   * @param comment the documentation comment associated with this parameter
   * @param metadata the annotations associated with this parameter
   * @param keyword the token representing either the 'final', 'const' or 'var' keyword
   * @param type the name of the declared type of the parameter
   * @param thisToken the token representing the 'this' keyword
   * @param period the token representing the period
   * @param identifier the name of the parameter being declared
   */
  FieldFormalParameter(Comment comment, List<Annotation> metadata, Token keyword, TypeName type, Token thisToken, Token period, SimpleIdentifier identifier) : super(comment, metadata, identifier) {
    this._keyword = keyword;
    this._type = becomeParentOf(type);
    this._thisToken = thisToken;
    this._period = period;
  }
  accept(ASTVisitor visitor) => visitor.visitFieldFormalParameter(this);
  Token get beginToken {
    if (_keyword != null) {
      return _keyword;
    } else if (_type != null) {
      return _type.beginToken;
    }
    return _thisToken;
  }
  Token get endToken => identifier.endToken;
  /**
   * Return the token representing either the 'final', 'const' or 'var' keyword.
   * @return the token representing either the 'final', 'const' or 'var' keyword
   */
  Token get keyword => _keyword;
  /**
   * Return the token representing the period.
   * @return the token representing the period
   */
  Token get period => _period;
  /**
   * Return the token representing the 'this' keyword.
   * @return the token representing the 'this' keyword
   */
  Token get thisToken => _thisToken;
  /**
   * Return the name of the declared type of the parameter, or {@code null} if the parameter does
   * not have a declared type.
   * @return the name of the declared type of the parameter
   */
  TypeName get type => _type;
  bool isConst() => (_keyword is KeywordToken) && (_keyword as KeywordToken).keyword == Keyword.CONST;
  bool isFinal() => (_keyword is KeywordToken) && (_keyword as KeywordToken).keyword == Keyword.FINAL;
  /**
   * Set the token representing either the 'final', 'const' or 'var' keyword to the given token.
   * @param keyword the token representing either the 'final', 'const' or 'var' keyword
   */
  void set keyword10(Token keyword) {
    this._keyword = keyword;
  }
  /**
   * Set the token representing the period to the given token.
   * @param period the token representing the period
   */
  void set period6(Token period) {
    this._period = period;
  }
  /**
   * Set the token representing the 'this' keyword to the given token.
   * @param thisToken the token representing the 'this' keyword
   */
  void set thisToken2(Token thisToken) {
    this._thisToken = thisToken;
  }
  /**
   * Set the name of the declared type of the parameter to the given type name.
   * @param typeName the name of the declared type of the parameter
   */
  void set type4(TypeName typeName) {
    _type = becomeParentOf(typeName);
  }
  void visitChildren(ASTVisitor<Object> visitor) {
    super.visitChildren(visitor);
    safelyVisitChild(_type, visitor);
    safelyVisitChild(identifier, visitor);
  }
}
/**
 * Instances of the class {@code ForEachStatement} represent a for-each statement.
 * <pre>
 * forEachStatement ::=
 * 'for' '(' {@link SimpleFormalParameter loopParameter} 'in' {@link Expression iterator} ')' {@link Block body}</pre>
 */
class ForEachStatement extends Statement {
  /**
   * The token representing the 'for' keyword.
   */
  Token _forKeyword;
  /**
   * The left parenthesis.
   */
  Token _leftParenthesis;
  /**
   * The declaration of the loop variable.
   */
  SimpleFormalParameter _loopParameter;
  /**
   * The token representing the 'in' keyword.
   */
  Token _inKeyword;
  /**
   * The expression evaluated to produce the iterator.
   */
  Expression _iterator;
  /**
   * The right parenthesis.
   */
  Token _rightParenthesis;
  /**
   * The body of the loop.
   */
  Statement _body;
  /**
   * Initialize a newly created for-each statement.
   * @param forKeyword the token representing the 'for' keyword
   * @param leftParenthesis the left parenthesis
   * @param loopParameter the declaration of the loop variable
   * @param iterator the expression evaluated to produce the iterator
   * @param rightParenthesis the right parenthesis
   * @param body the body of the loop
   */
  ForEachStatement(Token forKeyword, Token leftParenthesis, SimpleFormalParameter loopParameter, Token inKeyword, Expression iterator, Token rightParenthesis, Statement body) {
    this._forKeyword = forKeyword;
    this._leftParenthesis = leftParenthesis;
    this._loopParameter = becomeParentOf(loopParameter);
    this._inKeyword = inKeyword;
    this._iterator = becomeParentOf(iterator);
    this._rightParenthesis = rightParenthesis;
    this._body = becomeParentOf(body);
  }
  accept(ASTVisitor visitor) => visitor.visitForEachStatement(this);
  Token get beginToken => _forKeyword;
  /**
   * Return the body of the loop.
   * @return the body of the loop
   */
  Statement get body => _body;
  Token get endToken => _body.endToken;
  /**
   * Return the token representing the 'for' keyword.
   * @return the token representing the 'for' keyword
   */
  Token get forKeyword => _forKeyword;
  /**
   * Return the token representing the 'in' keyword.
   * @return the token representing the 'in' keyword
   */
  Token get inKeyword => _inKeyword;
  /**
   * Return the expression evaluated to produce the iterator.
   * @return the expression evaluated to produce the iterator
   */
  Expression get iterator => _iterator;
  /**
   * Return the left parenthesis.
   * @return the left parenthesis
   */
  Token get leftParenthesis => _leftParenthesis;
  /**
   * Return the declaration of the loop variable.
   * @return the declaration of the loop variable
   */
  SimpleFormalParameter get loopParameter => _loopParameter;
  /**
   * Return the right parenthesis.
   * @return the right parenthesis
   */
  Token get rightParenthesis => _rightParenthesis;
  /**
   * Set the body of the loop to the given block.
   * @param body the body of the loop
   */
  void set body5(Statement body) {
    this._body = becomeParentOf(body);
  }
  /**
   * Set the token representing the 'for' keyword to the given token.
   * @param forKeyword the token representing the 'for' keyword
   */
  void set forKeyword2(Token forKeyword) {
    this._forKeyword = forKeyword;
  }
  /**
   * Set the token representing the 'in' keyword to the given token.
   * @param inKeyword the token representing the 'in' keyword
   */
  void set inKeyword2(Token inKeyword) {
    this._inKeyword = inKeyword;
  }
  /**
   * Set the expression evaluated to produce the iterator to the given expression.
   * @param expression the expression evaluated to produce the iterator
   */
  void set iterator2(Expression expression) {
    _iterator = becomeParentOf(expression);
  }
  /**
   * Set the left parenthesis to the given token.
   * @param leftParenthesis the left parenthesis
   */
  void set leftParenthesis6(Token leftParenthesis) {
    this._leftParenthesis = leftParenthesis;
  }
  /**
   * Set the declaration of the loop variable to the given parameter.
   * @param parameter the declaration of the loop variable
   */
  void set loopParameter2(SimpleFormalParameter parameter) {
    _loopParameter = becomeParentOf(parameter);
  }
  /**
   * Set the right parenthesis to the given token.
   * @param rightParenthesis the right parenthesis
   */
  void set rightParenthesis6(Token rightParenthesis) {
    this._rightParenthesis = rightParenthesis;
  }
  void visitChildren(ASTVisitor<Object> visitor) {
    safelyVisitChild(_loopParameter, visitor);
    safelyVisitChild(_iterator, visitor);
    safelyVisitChild(_body, visitor);
  }
}
/**
 * Instances of the class {@code ForStatement} represent a for statement.
 * <pre>
 * forStatement ::=
 * 'for' '(' forLoopParts ')' {@link Statement statement}forLoopParts ::=
 * forInitializerStatement ';' {@link Expression expression}? ';' {@link Expression expressionList}?
 * forInitializerStatement ::={@link DefaultFormalParameter initializedVariableDeclaration}| {@link Expression expression}?
 * </pre>
 */
class ForStatement extends Statement {
  /**
   * The token representing the 'for' keyword.
   */
  Token _forKeyword;
  /**
   * The left parenthesis.
   */
  Token _leftParenthesis;
  /**
   * The declaration of the loop variables, or {@code null} if there are no variables. Note that a
   * for statement cannot have both a variable list and an initialization expression, but can
   * validly have neither.
   */
  VariableDeclarationList _variableList;
  /**
   * The initialization expression, or {@code null} if there is no initialization expression. Note
   * that a for statement cannot have both a variable list and an initialization expression, but can
   * validly have neither.
   */
  Expression _initialization;
  /**
   * The semicolon separating the initializer and the condition.
   */
  Token _leftSeparator;
  /**
   * The condition used to determine when to terminate the loop.
   */
  Expression _condition;
  /**
   * The semicolon separating the condition and the updater.
   */
  Token _rightSeparator;
  /**
   * The list of expressions run after each execution of the loop body.
   */
  NodeList<Expression> _updaters;
  /**
   * The right parenthesis.
   */
  Token _rightParenthesis;
  /**
   * The body of the loop.
   */
  Statement _body;
  /**
   * Initialize a newly created for statement.
   * @param forKeyword the token representing the 'for' keyword
   * @param leftParenthesis the left parenthesis
   * @param variableList the declaration of the loop variables
   * @param initialization the initialization expression
   * @param leftSeparator the semicolon separating the initializer and the condition
   * @param condition the condition used to determine when to terminate the loop
   * @param rightSeparator the semicolon separating the condition and the updater
   * @param updaters the list of expressions run after each execution of the loop body
   * @param rightParenthesis the right parenthesis
   * @param body the body of the loop
   */
  ForStatement(Token forKeyword, Token leftParenthesis, VariableDeclarationList variableList, Expression initialization, Token leftSeparator, Expression condition, Token rightSeparator, List<Expression> updaters, Token rightParenthesis, Statement body) {
    this._updaters = new NodeList<Expression>(this);
    this._forKeyword = forKeyword;
    this._leftParenthesis = leftParenthesis;
    this._variableList = becomeParentOf(variableList);
    this._initialization = becomeParentOf(initialization);
    this._leftSeparator = leftSeparator;
    this._condition = becomeParentOf(condition);
    this._rightSeparator = rightSeparator;
    this._updaters.addAll(updaters);
    this._rightParenthesis = rightParenthesis;
    this._body = becomeParentOf(body);
  }
  accept(ASTVisitor visitor) => visitor.visitForStatement(this);
  Token get beginToken => _forKeyword;
  /**
   * Return the body of the loop.
   * @return the body of the loop
   */
  Statement get body => _body;
  /**
   * Return the condition used to determine when to terminate the loop.
   * @return the condition used to determine when to terminate the loop
   */
  Expression get condition => _condition;
  Token get endToken => _body.endToken;
  /**
   * Return the token representing the 'for' keyword.
   * @return the token representing the 'for' keyword
   */
  Token get forKeyword => _forKeyword;
  /**
   * Return the initialization expression, or {@code null} if there is no initialization expression.
   * @return the initialization expression
   */
  Expression get initialization => _initialization;
  /**
   * Return the left parenthesis.
   * @return the left parenthesis
   */
  Token get leftParenthesis => _leftParenthesis;
  /**
   * Return the semicolon separating the initializer and the condition.
   * @return the semicolon separating the initializer and the condition
   */
  Token get leftSeparator => _leftSeparator;
  /**
   * Return the right parenthesis.
   * @return the right parenthesis
   */
  Token get rightParenthesis => _rightParenthesis;
  /**
   * Return the semicolon separating the condition and the updater.
   * @return the semicolon separating the condition and the updater
   */
  Token get rightSeparator => _rightSeparator;
  /**
   * Return the list of expressions run after each execution of the loop body.
   * @return the list of expressions run after each execution of the loop body
   */
  NodeList<Expression> get updaters => _updaters;
  /**
   * Return the declaration of the loop variables, or {@code null} if there are no variables.
   * @return the declaration of the loop variables, or {@code null} if there are no variables
   */
  VariableDeclarationList get variables => _variableList;
  /**
   * Set the body of the loop to the given statement.
   * @param body the body of the loop
   */
  void set body6(Statement body) {
    this._body = becomeParentOf(body);
  }
  /**
   * Set the condition used to determine when to terminate the loop to the given expression.
   * @param expression the condition used to determine when to terminate the loop
   */
  void set condition5(Expression expression) {
    _condition = becomeParentOf(expression);
  }
  /**
   * Set the token representing the 'for' keyword to the given token.
   * @param forKeyword the token representing the 'for' keyword
   */
  void set forKeyword3(Token forKeyword) {
    this._forKeyword = forKeyword;
  }
  /**
   * Set the initialization expression to the given expression.
   * @param initialization the initialization expression
   */
  void set initialization2(Expression initialization) {
    this._initialization = becomeParentOf(initialization);
  }
  /**
   * Set the left parenthesis to the given token.
   * @param leftParenthesis the left parenthesis
   */
  void set leftParenthesis7(Token leftParenthesis) {
    this._leftParenthesis = leftParenthesis;
  }
  /**
   * Set the semicolon separating the initializer and the condition to the given token.
   * @param leftSeparator the semicolon separating the initializer and the condition
   */
  void set leftSeparator2(Token leftSeparator) {
    this._leftSeparator = leftSeparator;
  }
  /**
   * Set the right parenthesis to the given token.
   * @param rightParenthesis the right parenthesis
   */
  void set rightParenthesis7(Token rightParenthesis) {
    this._rightParenthesis = rightParenthesis;
  }
  /**
   * Set the semicolon separating the condition and the updater to the given token.
   * @param rightSeparator the semicolon separating the condition and the updater
   */
  void set rightSeparator2(Token rightSeparator) {
    this._rightSeparator = rightSeparator;
  }
  /**
   * Set the declaration of the loop variables to the given parameter.
   * @param variableList the declaration of the loop variables
   */
  void set variables2(VariableDeclarationList variableList) {
    variableList = becomeParentOf(variableList);
  }
  void visitChildren(ASTVisitor<Object> visitor) {
    safelyVisitChild(_variableList, visitor);
    safelyVisitChild(_initialization, visitor);
    safelyVisitChild(_condition, visitor);
    _updaters.accept(visitor);
    safelyVisitChild(_body, visitor);
  }
}
/**
 * The abstract class {@code FormalParameter} defines the behavior of objects representing a
 * parameter to a function.
 * <pre>
 * formalParameter ::={@link NormalFormalParameter normalFormalParameter}| {@link DefaultFormalParameter namedFormalParameter}| {@link DefaultFormalParameter optionalFormalParameter}</pre>
 */
abstract class FormalParameter extends ASTNode {
  /**
   * Return the element representing this parameter, or {@code null} if this parameter has not been
   * resolved.
   * @return the element representing this parameter
   */
  ParameterElement get element {
    SimpleIdentifier identifier6 = identifier;
    if (identifier6 == null) {
      return null;
    }
    return identifier6.element as ParameterElement;
  }
  /**
   * Return the name of the parameter being declared.
   * @return the name of the parameter being declared
   */
  SimpleIdentifier get identifier;
  /**
   * Return the kind of this parameter.
   * @return the kind of this parameter
   */
  ParameterKind get kind;
}
/**
 * Instances of the class {@code FormalParameterList} represent the formal parameter list of a
 * method declaration, function declaration, or function type alias.
 * <p>
 * While the grammar requires all optional formal parameters to follow all of the normal formal
 * parameters and at most one grouping of optional formal parameters, this class does not enforce
 * those constraints. All parameters are flattened into a single list, which can have any or all
 * kinds of parameters (normal, named, and positional) in any order.
 * <pre>
 * formalParameterList ::=
 * '(' ')'
 * | '(' normalFormalParameters (',' optionalFormalParameters)? ')'
 * | '(' optionalFormalParameters ')'
 * normalFormalParameters ::={@link NormalFormalParameter normalFormalParameter} (',' {@link NormalFormalParameter normalFormalParameter})
 * optionalFormalParameters ::=
 * optionalPositionalFormalParameters
 * | namedFormalParameters
 * optionalPositionalFormalParameters ::=
 * '[' {@link DefaultFormalParameter positionalFormalParameter} (',' {@link DefaultFormalParameter positionalFormalParameter})* ']'
 * namedFormalParameters ::=
 * '{' {@link DefaultFormalParameter namedFormalParameter} (',' {@link DefaultFormalParameter namedFormalParameter})* '}'
 * </pre>
 */
class FormalParameterList extends ASTNode {
  /**
   * The left parenthesis.
   */
  Token _leftParenthesis;
  /**
   * The parameters associated with the method.
   */
  NodeList<FormalParameter> _parameters;
  /**
   * The left square bracket ('[') or left curly brace ('{') introducing the optional parameters.
   */
  Token _leftDelimiter;
  /**
   * The right square bracket (']') or right curly brace ('}') introducing the optional parameters.
   */
  Token _rightDelimiter;
  /**
   * The right parenthesis.
   */
  Token _rightParenthesis;
  /**
   * Initialize a newly created parameter list.
   * @param leftParenthesis the left parenthesis
   * @param parameters the parameters associated with the method
   * @param leftDelimiter the left delimiter introducing the optional parameters
   * @param rightDelimiter the right delimiter introducing the optional parameters
   * @param rightParenthesis the right parenthesis
   */
  FormalParameterList(Token leftParenthesis, List<FormalParameter> parameters, Token leftDelimiter, Token rightDelimiter, Token rightParenthesis) {
    this._parameters = new NodeList<FormalParameter>(this);
    this._leftParenthesis = leftParenthesis;
    this._parameters.addAll(parameters);
    this._leftDelimiter = leftDelimiter;
    this._rightDelimiter = rightDelimiter;
    this._rightParenthesis = rightParenthesis;
  }
  accept(ASTVisitor visitor) => visitor.visitFormalParameterList(this);
  Token get beginToken => _leftParenthesis;
  /**
   * Return an array containing the elements representing the parameters in this list. The array
   * will contain {@code null}s if the parameters in this list have not been resolved.
   * @return the elements representing the parameters in this list
   */
  List<ParameterElement> get elements {
    int count = _parameters.length;
    List<ParameterElement> types = new List<ParameterElement>.fixedLength(count);
    for (int i = 0; i < count; i++) {
      types[i] = _parameters[i].element;
    }
    return types;
  }
  Token get endToken => _rightParenthesis;
  /**
   * Return the left square bracket ('[') or left curly brace ('{') introducing the optional
   * parameters.
   * @return the left square bracket ('[') or left curly brace ('{') introducing the optional
   * parameters
   */
  Token get leftDelimiter => _leftDelimiter;
  /**
   * Return the left parenthesis.
   * @return the left parenthesis
   */
  Token get leftParenthesis => _leftParenthesis;
  /**
   * Return the parameters associated with the method.
   * @return the parameters associated with the method
   */
  NodeList<FormalParameter> get parameters => _parameters;
  /**
   * Return the right square bracket (']') or right curly brace ('}') introducing the optional
   * parameters.
   * @return the right square bracket (']') or right curly brace ('}') introducing the optional
   * parameters
   */
  Token get rightDelimiter => _rightDelimiter;
  /**
   * Return the right parenthesis.
   * @return the right parenthesis
   */
  Token get rightParenthesis => _rightParenthesis;
  /**
   * Set the left square bracket ('[') or left curly brace ('{') introducing the optional parameters
   * to the given token.
   * @param bracket the left delimiter introducing the optional parameters
   */
  void set leftDelimiter2(Token bracket) {
    _leftDelimiter = bracket;
  }
  /**
   * Set the left parenthesis to the given token.
   * @param parenthesis the left parenthesis
   */
  void set leftParenthesis8(Token parenthesis) {
    _leftParenthesis = parenthesis;
  }
  /**
   * Set the right square bracket (']') or right curly brace ('}') introducing the optional
   * parameters to the given token.
   * @param bracket the right delimiter introducing the optional parameters
   */
  void set rightDelimiter2(Token bracket) {
    _rightDelimiter = bracket;
  }
  /**
   * Set the right parenthesis to the given token.
   * @param parenthesis the right parenthesis
   */
  void set rightParenthesis8(Token parenthesis) {
    _rightParenthesis = parenthesis;
  }
  void visitChildren(ASTVisitor<Object> visitor) {
    _parameters.accept(visitor);
  }
}
/**
 * The abstract class {@code FunctionBody} defines the behavior common to objects representing the
 * body of a function or method.
 * <pre>
 * functionBody ::={@link BlockFunctionBody blockFunctionBody}| {@link EmptyFunctionBody emptyFunctionBody}| {@link ExpressionFunctionBody expressionFunctionBody}</pre>
 */
abstract class FunctionBody extends ASTNode {
}
/**
 * Instances of the class {@code FunctionDeclaration} wrap a {@link FunctionExpression function
 * expression} as a top-level declaration.
 * <pre>
 * functionDeclaration ::=
 * 'external' functionSignature
 * | functionSignature {@link FunctionBody functionBody}functionSignature ::={@link Type returnType}? ('get' | 'set')? {@link SimpleIdentifier functionName} {@link FormalParameterList formalParameterList}</pre>
 */
class FunctionDeclaration extends CompilationUnitMember {
  /**
   * The token representing the 'external' keyword, or {@code null} if this is not an external
   * function.
   */
  Token _externalKeyword;
  /**
   * The return type of the function, or {@code null} if no return type was declared.
   */
  TypeName _returnType;
  /**
   * The token representing the 'get' or 'set' keyword, or {@code null} if this is a function
   * declaration rather than a property declaration.
   */
  Token _propertyKeyword;
  /**
   * The name of the function, or {@code null} if the function is not named.
   */
  SimpleIdentifier _name;
  /**
   * The function expression being wrapped.
   */
  FunctionExpression _functionExpression;
  /**
   * Initialize a newly created function declaration.
   * @param comment the documentation comment associated with this function
   * @param metadata the annotations associated with this function
   * @param externalKeyword the token representing the 'external' keyword
   * @param returnType the return type of the function
   * @param propertyKeyword the token representing the 'get' or 'set' keyword
   * @param name the name of the function
   * @param functionExpression the function expression being wrapped
   */
  FunctionDeclaration(Comment comment, List<Annotation> metadata, Token externalKeyword, TypeName returnType, Token propertyKeyword, SimpleIdentifier name, FunctionExpression functionExpression) : super(comment, metadata) {
    this._externalKeyword = externalKeyword;
    this._returnType = becomeParentOf(returnType);
    this._propertyKeyword = propertyKeyword;
    this._name = becomeParentOf(name);
    this._functionExpression = becomeParentOf(functionExpression);
  }
  accept(ASTVisitor visitor) => visitor.visitFunctionDeclaration(this);
  /**
   * Return the {@link FunctionElement} associated with this function, or {@code null} if the AST
   * structure has not been resolved.
   * @return the {@link FunctionElement} associated with this function
   */
  FunctionElement get element => _name != null ? _name.element as FunctionElement : null;
  Token get endToken => _functionExpression.endToken;
  /**
   * Return the token representing the 'external' keyword, or {@code null} if this is not an
   * external function.
   * @return the token representing the 'external' keyword
   */
  Token get externalKeyword => _externalKeyword;
  /**
   * Return the function expression being wrapped.
   * @return the function expression being wrapped
   */
  FunctionExpression get functionExpression => _functionExpression;
  /**
   * Return the name of the function, or {@code null} if the function is not named.
   * @return the name of the function
   */
  SimpleIdentifier get name => _name;
  /**
   * Return the token representing the 'get' or 'set' keyword, or {@code null} if this is a function
   * declaration rather than a property declaration.
   * @return the token representing the 'get' or 'set' keyword
   */
  Token get propertyKeyword => _propertyKeyword;
  /**
   * Return the return type of the function, or {@code null} if no return type was declared.
   * @return the return type of the function
   */
  TypeName get returnType => _returnType;
  /**
   * Set the token representing the 'external' keyword to the given token.
   * @param externalKeyword the token representing the 'external' keyword
   */
  void set externalKeyword3(Token externalKeyword) {
    this._externalKeyword = externalKeyword;
  }
  /**
   * Set the function expression being wrapped to the given function expression.
   * @param functionExpression the function expression being wrapped
   */
  void set functionExpression2(FunctionExpression functionExpression) {
    functionExpression = becomeParentOf(functionExpression);
  }
  /**
   * Set the name of the function to the given identifier.
   * @param identifier the name of the function
   */
  void set name7(SimpleIdentifier identifier) {
    _name = becomeParentOf(identifier);
  }
  /**
   * Set the token representing the 'get' or 'set' keyword to the given token.
   * @param propertyKeyword the token representing the 'get' or 'set' keyword
   */
  void set propertyKeyword2(Token propertyKeyword) {
    this._propertyKeyword = propertyKeyword;
  }
  /**
   * Set the return type of the function to the given name.
   * @param name the return type of the function
   */
  void set returnType3(TypeName name) {
    _returnType = becomeParentOf(name);
  }
  void visitChildren(ASTVisitor<Object> visitor) {
    super.visitChildren(visitor);
    safelyVisitChild(_returnType, visitor);
    safelyVisitChild(_name, visitor);
    safelyVisitChild(_functionExpression, visitor);
  }
  Token get firstTokenAfterCommentAndMetadata {
    if (_externalKeyword != null) {
      return _externalKeyword;
    }
    if (_returnType != null) {
      return _returnType.beginToken;
    } else if (_propertyKeyword != null) {
      return _propertyKeyword;
    } else if (_name != null) {
      return _name.beginToken;
    }
    return _functionExpression.beginToken;
  }
}
/**
 * Instances of the class {@code FunctionDeclarationStatement} wrap a {@link FunctionDeclarationfunction declaration} as a statement.
 */
class FunctionDeclarationStatement extends Statement {
  /**
   * The function declaration being wrapped.
   */
  FunctionDeclaration _functionDeclaration;
  /**
   * Initialize a newly created function declaration statement.
   * @param functionDeclaration the the function declaration being wrapped
   */
  FunctionDeclarationStatement(FunctionDeclaration functionDeclaration) {
    this._functionDeclaration = becomeParentOf(functionDeclaration);
  }
  accept(ASTVisitor visitor) => visitor.visitFunctionDeclarationStatement(this);
  Token get beginToken => _functionDeclaration.beginToken;
  Token get endToken => _functionDeclaration.endToken;
  /**
   * Return the function declaration being wrapped.
   * @return the function declaration being wrapped
   */
  FunctionDeclaration get functionDeclaration => _functionDeclaration;
  /**
   * Set the function declaration being wrapped to the given function declaration.
   * @param functionDeclaration the function declaration being wrapped
   */
  void set functionExpression(FunctionDeclaration functionDeclaration) {
    this._functionDeclaration = becomeParentOf(functionDeclaration);
  }
  void visitChildren(ASTVisitor<Object> visitor) {
    safelyVisitChild(_functionDeclaration, visitor);
  }
}
/**
 * Instances of the class {@code FunctionExpression} represent a function expression.
 * <pre>
 * functionExpression ::={@link FormalParameterList formalParameterList} {@link FunctionBody functionBody}</pre>
 */
class FunctionExpression extends Expression {
  /**
   * The parameters associated with the function.
   */
  FormalParameterList _parameters;
  /**
   * The body of the function, or {@code null} if this is an external function.
   */
  FunctionBody _body;
  /**
   * The element associated with the function, or {@code null} if the AST structure has not been
   * resolved.
   */
  ExecutableElement _element;
  /**
   * Initialize a newly created function declaration.
   * @param parameters the parameters associated with the function
   * @param body the body of the function
   */
  FunctionExpression(FormalParameterList parameters, FunctionBody body) {
    this._parameters = becomeParentOf(parameters);
    this._body = becomeParentOf(body);
  }
  accept(ASTVisitor visitor) => visitor.visitFunctionExpression(this);
  Token get beginToken {
    if (_parameters != null) {
      return _parameters.beginToken;
    } else if (_body != null) {
      return _body.beginToken;
    }
    throw new IllegalStateException("Non-external functions must have a body");
  }
  /**
   * Return the body of the function, or {@code null} if this is an external function.
   * @return the body of the function
   */
  FunctionBody get body => _body;
  /**
   * Return the element associated with this function, or {@code null} if the AST structure has not
   * been resolved.
   * @return the element associated with this function
   */
  ExecutableElement get element => _element;
  Token get endToken {
    if (_body != null) {
      return _body.endToken;
    } else if (_parameters != null) {
      return _parameters.endToken;
    }
    throw new IllegalStateException("Non-external functions must have a body");
  }
  /**
   * Return the parameters associated with the function.
   * @return the parameters associated with the function
   */
  FormalParameterList get parameters => _parameters;
  /**
   * Set the body of the function to the given function body.
   * @param functionBody the body of the function
   */
  void set body7(FunctionBody functionBody) {
    _body = becomeParentOf(functionBody);
  }
  /**
   * Set the element associated with this function to the given element.
   * @param element the element associated with this function
   */
  void set element8(ExecutableElement element) {
    this._element = element;
  }
  /**
   * Set the parameters associated with the function to the given list of parameters.
   * @param parameters the parameters associated with the function
   */
  void set parameters3(FormalParameterList parameters) {
    this._parameters = becomeParentOf(parameters);
  }
  void visitChildren(ASTVisitor<Object> visitor) {
    safelyVisitChild(_parameters, visitor);
    safelyVisitChild(_body, visitor);
  }
}
/**
 * Instances of the class {@code FunctionExpressionInvocation} represent the invocation of a
 * function resulting from evaluating an expression. Invocations of methods and other forms of
 * functions are represented by {@link MethodInvocation method invocation} nodes. Invocations of
 * getters and setters are represented by either {@link PrefixedIdentifier prefixed identifier} or{@link PropertyAccess property access} nodes.
 * <pre>
 * functionExpressionInvoction ::={@link Expression function} {@link ArgumentList argumentList}</pre>
 */
class FunctionExpressionInvocation extends Expression {
  /**
   * The expression producing the function being invoked.
   */
  Expression _function;
  /**
   * The list of arguments to the function.
   */
  ArgumentList _argumentList;
  /**
   * The element associated with the function being invoked, or {@code null} if the AST structure
   * has not been resolved or the function could not be resolved.
   */
  ExecutableElement _element;
  /**
   * Initialize a newly created function expression invocation.
   * @param function the expression producing the function being invoked
   * @param argumentList the list of arguments to the method
   */
  FunctionExpressionInvocation(Expression function, ArgumentList argumentList) {
    this._function = becomeParentOf(function);
    this._argumentList = becomeParentOf(argumentList);
  }
  accept(ASTVisitor visitor) => visitor.visitFunctionExpressionInvocation(this);
  /**
   * Return the list of arguments to the method.
   * @return the list of arguments to the method
   */
  ArgumentList get argumentList => _argumentList;
  Token get beginToken => _function.beginToken;
  /**
   * Return the element associated with the function being invoked, or {@code null} if the AST
   * structure has not been resolved or the function could not be resolved. One common example of
   * the latter case is an expression whose value can change over time.
   * @return the element associated with the function being invoked
   */
  ExecutableElement get element => _element;
  Token get endToken => _argumentList.endToken;
  /**
   * Return the expression producing the function being invoked.
   * @return the expression producing the function being invoked
   */
  Expression get function => _function;
  /**
   * Set the list of arguments to the method to the given list.
   * @param argumentList the list of arguments to the method
   */
  void set argumentList5(ArgumentList argumentList) {
    this._argumentList = becomeParentOf(argumentList);
  }
  /**
   * Set the element associated with the function being invoked to the given element.
   * @param element the element associated with the function being invoked
   */
  void set element9(ExecutableElement element) {
    this._element = element;
  }
  /**
   * Set the expression producing the function being invoked to the given expression.
   * @param function the expression producing the function being invoked
   */
  void set function2(Expression function) {
    function = becomeParentOf(function);
  }
  void visitChildren(ASTVisitor<Object> visitor) {
    safelyVisitChild(_function, visitor);
    safelyVisitChild(_argumentList, visitor);
  }
}
/**
 * Instances of the class {@code FunctionTypeAlias} represent a function type alias.
 * <pre>
 * functionTypeAlias ::=
 * functionPrefix {@link TypeParameterList typeParameterList}? {@link FormalParameterList formalParameterList} ';'
 * functionPrefix ::={@link TypeName returnType}? {@link SimpleIdentifier name}</pre>
 */
class FunctionTypeAlias extends TypeAlias {
  /**
   * The name of the return type of the function type being defined, or {@code null} if no return
   * type was given.
   */
  TypeName _returnType;
  /**
   * The name of the function type being declared.
   */
  SimpleIdentifier _name;
  /**
   * The type parameters for the function type, or {@code null} if the function type does not have
   * any type parameters.
   */
  TypeParameterList _typeParameters;
  /**
   * The parameters associated with the function type.
   */
  FormalParameterList _parameters;
  /**
   * Initialize a newly created function type alias.
   * @param comment the documentation comment associated with this type alias
   * @param metadata the annotations associated with this type alias
   * @param keyword the token representing the 'typedef' keyword
   * @param returnType the name of the return type of the function type being defined
   * @param name the name of the type being declared
   * @param typeParameters the type parameters for the type
   * @param parameters the parameters associated with the function
   * @param semicolon the semicolon terminating the declaration
   */
  FunctionTypeAlias(Comment comment, List<Annotation> metadata, Token keyword, TypeName returnType, SimpleIdentifier name, TypeParameterList typeParameters, FormalParameterList parameters, Token semicolon) : super(comment, metadata, keyword, semicolon) {
    this._returnType = becomeParentOf(returnType);
    this._name = becomeParentOf(name);
    this._typeParameters = becomeParentOf(typeParameters);
    this._parameters = becomeParentOf(parameters);
  }
  accept(ASTVisitor visitor) => visitor.visitFunctionTypeAlias(this);
  /**
   * Return the {@link TypeAliasElement} associated with this type alias, or {@code null} if the AST
   * structure has not been resolved.
   * @return the {@link TypeAliasElement} associated with this type alias
   */
  TypeAliasElement get element => _name != null ? _name.element as TypeAliasElement : null;
  /**
   * Return the name of the function type being declared.
   * @return the name of the function type being declared
   */
  SimpleIdentifier get name => _name;
  /**
   * Return the parameters associated with the function type.
   * @return the parameters associated with the function type
   */
  FormalParameterList get parameters => _parameters;
  /**
   * Return the name of the return type of the function type being defined, or {@code null} if no
   * return type was given.
   * @return the name of the return type of the function type being defined
   */
  TypeName get returnType => _returnType;
  /**
   * Return the type parameters for the function type, or {@code null} if the function type does not
   * have any type parameters.
   * @return the type parameters for the function type
   */
  TypeParameterList get typeParameters => _typeParameters;
  /**
   * Set the name of the function type being declared to the given identifier.
   * @param name the name of the function type being declared
   */
  void set name8(SimpleIdentifier name) {
    this._name = becomeParentOf(name);
  }
  /**
   * Set the parameters associated with the function type to the given list of parameters.
   * @param parameters the parameters associated with the function type
   */
  void set parameters4(FormalParameterList parameters) {
    this._parameters = becomeParentOf(parameters);
  }
  /**
   * Set the name of the return type of the function type being defined to the given type name.
   * @param typeName the name of the return type of the function type being defined
   */
  void set returnType4(TypeName typeName) {
    _returnType = becomeParentOf(typeName);
  }
  /**
   * Set the type parameters for the function type to the given list of parameters.
   * @param typeParameters the type parameters for the function type
   */
  void set typeParameters4(TypeParameterList typeParameters) {
    this._typeParameters = becomeParentOf(typeParameters);
  }
  void visitChildren(ASTVisitor<Object> visitor) {
    super.visitChildren(visitor);
    safelyVisitChild(_returnType, visitor);
    safelyVisitChild(_name, visitor);
    safelyVisitChild(_typeParameters, visitor);
    safelyVisitChild(_parameters, visitor);
  }
}
/**
 * Instances of the class {@code FunctionTypedFormalParameter} represent a function-typed formal
 * parameter.
 * <pre>
 * functionSignature ::={@link TypeName returnType}? {@link SimpleIdentifier identifier} {@link FormalParameterList formalParameterList}</pre>
 */
class FunctionTypedFormalParameter extends NormalFormalParameter {
  /**
   * The return type of the function, or {@code null} if the function does not have a return type.
   */
  TypeName _returnType;
  /**
   * The parameters of the function-typed parameter.
   */
  FormalParameterList _parameters;
  /**
   * Initialize a newly created formal parameter.
   * @param comment the documentation comment associated with this parameter
   * @param metadata the annotations associated with this parameter
   * @param returnType the return type of the function, or {@code null} if the function does not
   * have a return type
   * @param identifier the name of the function-typed parameter
   * @param parameters the parameters of the function-typed parameter
   */
  FunctionTypedFormalParameter(Comment comment, List<Annotation> metadata, TypeName returnType, SimpleIdentifier identifier, FormalParameterList parameters) : super(comment, metadata, identifier) {
    this._returnType = becomeParentOf(returnType);
    this._parameters = becomeParentOf(parameters);
  }
  accept(ASTVisitor visitor) => visitor.visitFunctionTypedFormalParameter(this);
  Token get beginToken {
    if (_returnType != null) {
      return _returnType.beginToken;
    }
    return identifier.beginToken;
  }
  Token get endToken => _parameters.endToken;
  /**
   * Return the parameters of the function-typed parameter.
   * @return the parameters of the function-typed parameter
   */
  FormalParameterList get parameters => _parameters;
  /**
   * Return the return type of the function, or {@code null} if the function does not have a return
   * type.
   * @return the return type of the function
   */
  TypeName get returnType => _returnType;
  bool isConst() => false;
  bool isFinal() => false;
  /**
   * Set the parameters of the function-typed parameter to the given parameters.
   * @param parameters the parameters of the function-typed parameter
   */
  void set parameters5(FormalParameterList parameters) {
    this._parameters = becomeParentOf(parameters);
  }
  /**
   * Set the return type of the function to the given type.
   * @param returnType the return type of the function
   */
  void set returnType5(TypeName returnType) {
    this._returnType = becomeParentOf(returnType);
  }
  void visitChildren(ASTVisitor<Object> visitor) {
    super.visitChildren(visitor);
    safelyVisitChild(_returnType, visitor);
    safelyVisitChild(identifier, visitor);
    safelyVisitChild(_parameters, visitor);
  }
}
/**
 * Instances of the class {@code HideCombinator} represent a combinator that restricts the names
 * being imported to those that are not in a given list.
 * <pre>
 * hideCombinator ::=
 * 'hide' {@link SimpleIdentifier identifier} (',' {@link SimpleIdentifier identifier})
 * </pre>
 */
class HideCombinator extends Combinator {
  /**
   * The list of names from the library that are hidden by this combinator.
   */
  NodeList<SimpleIdentifier> _hiddenNames;
  /**
   * Initialize a newly created import show combinator.
   * @param keyword the comma introducing the combinator
   * @param hiddenNames the list of names from the library that are hidden by this combinator
   */
  HideCombinator(Token keyword, List<SimpleIdentifier> hiddenNames) : super(keyword) {
    this._hiddenNames = new NodeList<SimpleIdentifier>(this);
    this._hiddenNames.addAll(hiddenNames);
  }
  accept(ASTVisitor visitor) => visitor.visitHideCombinator(this);
  Token get endToken => _hiddenNames.endToken;
  /**
   * Return the list of names from the library that are hidden by this combinator.
   * @return the list of names from the library that are hidden by this combinator
   */
  NodeList<SimpleIdentifier> get hiddenNames => _hiddenNames;
  void visitChildren(ASTVisitor<Object> visitor) {
    _hiddenNames.accept(visitor);
  }
}
/**
 * The abstract class {@code Identifier} defines the behavior common to nodes that represent an
 * identifier.
 * <pre>
 * identifier ::={@link SimpleIdentifier simpleIdentifier}| {@link PrefixedIdentifier prefixedIdentifier}</pre>
 */
abstract class Identifier extends Expression {
  /**
   * Return {@code true} if the given name is visible only within the library in which it is
   * declared.
   * @param name the name being tested
   * @return {@code true} if the given name is private
   */
  static bool isPrivateName(String name) => name.startsWith("_");
  /**
   * The element associated with this identifier, or {@code null} if the AST structure has not been
   * resolved or if this identifier could not be resolved.
   */
  Element _element;
  /**
   * Return the element associated with this identifier, or {@code null} if the AST structure has
   * not been resolved or if this identifier could not be resolved. One example of the latter case
   * is an identifier that is not defined within the scope in which it appears.
   * @return the element associated with this identifier
   */
  Element get element => _element;
  /**
   * Return the lexical representation of the identifier.
   * @return the lexical representation of the identifier
   */
  String get name;
  bool isAssignable() => true;
  /**
   * Set the element associated with this identifier to the given element.
   * @param element the element associated with this identifier
   */
  void set element10(Element element) {
    this._element = element;
  }
}
/**
 * Instances of the class {@code IfStatement} represent an if statement.
 * <pre>
 * ifStatement ::=
 * 'if' '(' {@link Expression expression} ')' {@link Statement thenStatement} ('else' {@link Statement elseStatement})?
 * </pre>
 */
class IfStatement extends Statement {
  /**
   * The token representing the 'if' keyword.
   */
  Token _ifKeyword;
  /**
   * The left parenthesis.
   */
  Token _leftParenthesis;
  /**
   * The condition used to determine which of the statements is executed next.
   */
  Expression _condition;
  /**
   * The right parenthesis.
   */
  Token _rightParenthesis;
  /**
   * The statement that is executed if the condition evaluates to {@code true}.
   */
  Statement _thenStatement;
  /**
   * The token representing the 'else' keyword.
   */
  Token _elseKeyword;
  /**
   * The statement that is executed if the condition evaluates to {@code false}, or {@code null} if
   * there is no else statement.
   */
  Statement _elseStatement;
  /**
   * Initialize a newly created if statement.
   * @param ifKeyword the token representing the 'if' keyword
   * @param leftParenthesis the left parenthesis
   * @param condition the condition used to determine which of the statements is executed next
   * @param rightParenthesis the right parenthesis
   * @param thenStatement the statement that is executed if the condition evaluates to {@code true}
   * @param elseKeyword the token representing the 'else' keyword
   * @param elseStatement the statement that is executed if the condition evaluates to {@code false}
   */
  IfStatement(Token ifKeyword, Token leftParenthesis, Expression condition, Token rightParenthesis, Statement thenStatement, Token elseKeyword, Statement elseStatement) {
    this._ifKeyword = ifKeyword;
    this._leftParenthesis = leftParenthesis;
    this._condition = becomeParentOf(condition);
    this._rightParenthesis = rightParenthesis;
    this._thenStatement = becomeParentOf(thenStatement);
    this._elseKeyword = elseKeyword;
    this._elseStatement = becomeParentOf(elseStatement);
  }
  accept(ASTVisitor visitor) => visitor.visitIfStatement(this);
  Token get beginToken => _ifKeyword;
  /**
   * Return the condition used to determine which of the statements is executed next.
   * @return the condition used to determine which statement is executed next
   */
  Expression get condition => _condition;
  /**
   * Return the token representing the 'else' keyword.
   * @return the token representing the 'else' keyword
   */
  Token get elseKeyword => _elseKeyword;
  /**
   * Return the statement that is executed if the condition evaluates to {@code false}, or{@code null} if there is no else statement.
   * @return the statement that is executed if the condition evaluates to {@code false}
   */
  Statement get elseStatement => _elseStatement;
  Token get endToken {
    if (_elseStatement != null) {
      return _elseStatement.endToken;
    }
    return _thenStatement.endToken;
  }
  /**
   * Return the token representing the 'if' keyword.
   * @return the token representing the 'if' keyword
   */
  Token get ifKeyword => _ifKeyword;
  /**
   * Return the left parenthesis.
   * @return the left parenthesis
   */
  Token get leftParenthesis => _leftParenthesis;
  /**
   * Return the right parenthesis.
   * @return the right parenthesis
   */
  Token get rightParenthesis => _rightParenthesis;
  /**
   * Return the statement that is executed if the condition evaluates to {@code true}.
   * @return the statement that is executed if the condition evaluates to {@code true}
   */
  Statement get thenStatement => _thenStatement;
  /**
   * Set the condition used to determine which of the statements is executed next to the given
   * expression.
   * @param expression the condition used to determine which statement is executed next
   */
  void set condition6(Expression expression) {
    _condition = becomeParentOf(expression);
  }
  /**
   * Set the token representing the 'else' keyword to the given token.
   * @param elseKeyword the token representing the 'else' keyword
   */
  void set elseKeyword2(Token elseKeyword) {
    this._elseKeyword = elseKeyword;
  }
  /**
   * Set the statement that is executed if the condition evaluates to {@code false} to the given
   * statement.
   * @param statement the statement that is executed if the condition evaluates to {@code false}
   */
  void set elseStatement2(Statement statement) {
    _elseStatement = becomeParentOf(statement);
  }
  /**
   * Set the token representing the 'if' keyword to the given token.
   * @param ifKeyword the token representing the 'if' keyword
   */
  void set ifKeyword2(Token ifKeyword) {
    this._ifKeyword = ifKeyword;
  }
  /**
   * Set the left parenthesis to the given token.
   * @param leftParenthesis the left parenthesis
   */
  void set leftParenthesis9(Token leftParenthesis) {
    this._leftParenthesis = leftParenthesis;
  }
  /**
   * Set the right parenthesis to the given token.
   * @param rightParenthesis the right parenthesis
   */
  void set rightParenthesis9(Token rightParenthesis) {
    this._rightParenthesis = rightParenthesis;
  }
  /**
   * Set the statement that is executed if the condition evaluates to {@code true} to the given
   * statement.
   * @param statement the statement that is executed if the condition evaluates to {@code true}
   */
  void set thenStatement2(Statement statement) {
    _thenStatement = becomeParentOf(statement);
  }
  void visitChildren(ASTVisitor<Object> visitor) {
    safelyVisitChild(_condition, visitor);
    safelyVisitChild(_thenStatement, visitor);
    safelyVisitChild(_elseStatement, visitor);
  }
}
/**
 * Instances of the class {@code ImplementsClause} represent the "implements" clause in an class
 * declaration.
 * <pre>
 * implementsClause ::=
 * 'implements' {@link TypeName superclass} (',' {@link TypeName superclass})
 * </pre>
 */
class ImplementsClause extends ASTNode {
  /**
   * The token representing the 'implements' keyword.
   */
  Token _keyword;
  /**
   * The interfaces that are being implemented.
   */
  NodeList<TypeName> _interfaces;
  /**
   * Initialize a newly created extends clause.
   * @param keyword the token representing the 'implements' keyword
   * @param interfaces the interfaces that are being implemented
   */
  ImplementsClause(Token keyword, List<TypeName> interfaces) {
    this._interfaces = new NodeList<TypeName>(this);
    this._keyword = keyword;
    this._interfaces.addAll(interfaces);
  }
  accept(ASTVisitor visitor) => visitor.visitImplementsClause(this);
  Token get beginToken => _keyword;
  Token get endToken => _interfaces.endToken;
  /**
   * Return the list of the interfaces that are being implemented.
   * @return the list of the interfaces that are being implemented
   */
  NodeList<TypeName> get interfaces => _interfaces;
  /**
   * Return the token representing the 'implements' keyword.
   * @return the token representing the 'implements' keyword
   */
  Token get keyword => _keyword;
  /**
   * Set the token representing the 'implements' keyword to the given token.
   * @param keyword the token representing the 'implements' keyword
   */
  void set keyword11(Token keyword) {
    this._keyword = keyword;
  }
  void visitChildren(ASTVisitor<Object> visitor) {
    _interfaces.accept(visitor);
  }
}
/**
 * Instances of the class {@code ImportDirective} represent an import directive.
 * <pre>
 * importDirective ::={@link Annotation metadata} 'import' {@link StringLiteral libraryUri} ('as' identifier)? {@link Combinator combinator}* ';'
 * </pre>
 */
class ImportDirective extends NamespaceDirective {
  /**
   * The token representing the 'as' token, or {@code null} if the imported names are not prefixed.
   */
  Token _asToken;
  /**
   * The prefix to be used with the imported names, or {@code null} if the imported names are not
   * prefixed.
   */
  SimpleIdentifier _prefix;
  /**
   * Initialize a newly created import directive.
   * @param comment the documentation comment associated with this directive
   * @param metadata the annotations associated with the directive
   * @param keyword the token representing the 'import' keyword
   * @param libraryUri the URI of the library being imported
   * @param asToken the token representing the 'as' token
   * @param prefix the prefix to be used with the imported names
   * @param combinators the combinators used to control how names are imported
   * @param semicolon the semicolon terminating the directive
   */
  ImportDirective(Comment comment, List<Annotation> metadata, Token keyword, StringLiteral libraryUri, Token asToken, SimpleIdentifier prefix, List<Combinator> combinators, Token semicolon) : super(comment, metadata, keyword, libraryUri, combinators, semicolon) {
    this._asToken = asToken;
    this._prefix = becomeParentOf(prefix);
  }
  accept(ASTVisitor visitor) => visitor.visitImportDirective(this);
  /**
   * Return the token representing the 'as' token, or {@code null} if the imported names are not
   * prefixed.
   * @return the token representing the 'as' token
   */
  Token get asToken => _asToken;
  /**
   * Return the prefix to be used with the imported names, or {@code null} if the imported names are
   * not prefixed.
   * @return the prefix to be used with the imported names
   */
  SimpleIdentifier get prefix => _prefix;
  /**
   * Set the token representing the 'as' token to the given token.
   * @param asToken the token representing the 'as' token
   */
  void set asToken2(Token asToken) {
    this._asToken = asToken;
  }
  /**
   * Set the prefix to be used with the imported names to the given identifier.
   * @param prefix the prefix to be used with the imported names
   */
  void set prefix2(SimpleIdentifier prefix) {
    this._prefix = becomeParentOf(prefix);
  }
  void visitChildren(ASTVisitor<Object> visitor) {
    super.visitChildren(visitor);
    safelyVisitChild(libraryUri, visitor);
    safelyVisitChild(_prefix, visitor);
    combinators.accept(visitor);
  }
}
/**
 * Instances of the class {@code IndexExpression} represent an index expression.
 * <pre>
 * indexExpression ::={@link Expression target} '[' {@link Expression index} ']'
 * </pre>
 */
class IndexExpression extends Expression {
  /**
   * The expression used to compute the object being indexed, or {@code null} if this index
   * expression is part of a cascade expression.
   */
  Expression _target;
  /**
   * The period ("..") before a cascaded index expression, or {@code null} if this index expression
   * is not part of a cascade expression.
   */
  Token _period;
  /**
   * The left square bracket.
   */
  Token _leftBracket;
  /**
   * The expression used to compute the index.
   */
  Expression _index;
  /**
   * The right square bracket.
   */
  Token _rightBracket;
  /**
   * The element associated with the operator, or {@code null} if the AST structure has not been
   * resolved or if the operator could not be resolved.
   */
  MethodElement _element;
  /**
   * Initialize a newly created index expression.
   * @param target the expression used to compute the object being indexed
   * @param leftBracket the left square bracket
   * @param index the expression used to compute the index
   * @param rightBracket the right square bracket
   */
  IndexExpression.con1(Expression target, Token leftBracket, Expression index, Token rightBracket) {
    _jtd_constructor_55_impl(target, leftBracket, index, rightBracket);
  }
  _jtd_constructor_55_impl(Expression target, Token leftBracket, Expression index, Token rightBracket) {
    this._target = becomeParentOf(target);
    this._leftBracket = leftBracket;
    this._index = becomeParentOf(index);
    this._rightBracket = rightBracket;
  }
  /**
   * Initialize a newly created index expression.
   * @param period the period ("..") before a cascaded index expression
   * @param leftBracket the left square bracket
   * @param index the expression used to compute the index
   * @param rightBracket the right square bracket
   */
  IndexExpression.con2(Token period, Token leftBracket, Expression index, Token rightBracket) {
    _jtd_constructor_56_impl(period, leftBracket, index, rightBracket);
  }
  _jtd_constructor_56_impl(Token period, Token leftBracket, Expression index, Token rightBracket) {
    this._period = period;
    this._leftBracket = leftBracket;
    this._index = becomeParentOf(index);
    this._rightBracket = rightBracket;
  }
  accept(ASTVisitor visitor) => visitor.visitIndexExpression(this);
  /**
   * Return the expression used to compute the object being indexed, or {@code null} if this index
   * expression is part of a cascade expression.
   * @return the expression used to compute the object being indexed
   * @see #getRealTarget()
   */
  Expression get array => _target;
  Token get beginToken {
    if (_target != null) {
      return _target.beginToken;
    }
    return _period;
  }
  /**
   * Return the element associated with the operator, or {@code null} if the AST structure has not
   * been resolved or if the operator could not be resolved. One example of the latter case is an
   * operator that is not defined for the type of the left-hand operand.
   * @return the element associated with this operator
   */
  MethodElement get element => _element;
  Token get endToken => _rightBracket;
  /**
   * Return the expression used to compute the index.
   * @return the expression used to compute the index
   */
  Expression get index => _index;
  /**
   * Return the left square bracket.
   * @return the left square bracket
   */
  Token get leftBracket => _leftBracket;
  /**
   * Return the period ("..") before a cascaded index expression, or {@code null} if this index
   * expression is not part of a cascade expression.
   * @return the period ("..") before a cascaded index expression
   */
  Token get period => _period;
  /**
   * Return the expression used to compute the object being indexed. If this index expression is not
   * part of a cascade expression, then this is the same as {@link #getArray()}. If this index
   * expression is part of a cascade expression, then the target expression stored with the cascade
   * expression is returned.
   * @return the expression used to compute the object being indexed
   * @see #getArray()
   */
  Expression get realTarget {
    if (isCascaded()) {
      ASTNode ancestor = parent;
      while (ancestor is! CascadeExpression) {
        if (ancestor == null) {
          return _target;
        }
        ancestor = ancestor.parent;
      }
      return (ancestor as CascadeExpression).target;
    }
    return _target;
  }
  /**
   * Return the right square bracket.
   * @return the right square bracket
   */
  Token get rightBracket => _rightBracket;
  /**
   * Return {@code true} if this expression is computing a right-hand value.
   * <p>
   * Note that {@link #inGetterContext()} and {@link #inSetterContext()} are not opposites, nor are
   * they mutually exclusive. In other words, it is possible for both methods to return {@code true}when invoked on the same node.
   * @return {@code true} if this expression is in a context where the operator '[]' will be invoked
   */
  bool inGetterContext() {
    ASTNode parent4 = parent;
    if (parent4 is AssignmentExpression) {
      AssignmentExpression assignment = parent4 as AssignmentExpression;
      if (assignment.leftHandSide == this && assignment.operator.type == TokenType.EQ) {
        return false;
      }
    }
    return true;
  }
  /**
   * Return {@code true} if this expression is computing a left-hand value.
   * <p>
   * Note that {@link #inGetterContext()} and {@link #inSetterContext()} are not opposites, nor are
   * they mutually exclusive. In other words, it is possible for both methods to return {@code true}when invoked on the same node.
   * @return {@code true} if this expression is in a context where the operator '[]=' will be
   * invoked
   */
  bool inSetterContext() {
    ASTNode parent5 = parent;
    if (parent5 is PrefixExpression) {
      return (parent5 as PrefixExpression).operator.type.isIncrementOperator();
    } else if (parent5 is PostfixExpression) {
      return true;
    } else if (parent5 is AssignmentExpression) {
      return (parent5 as AssignmentExpression).leftHandSide == this;
    }
    return false;
  }
  bool isAssignable() => true;
  /**
   * Return {@code true} if this expression is cascaded. If it is, then the target of this
   * expression is not stored locally but is stored in the nearest ancestor that is a{@link CascadeExpression}.
   * @return {@code true} if this expression is cascaded
   */
  bool isCascaded() => _period != null;
  /**
   * Set the expression used to compute the object being indexed to the given expression.
   * @param expression the expression used to compute the object being indexed
   */
  void set array2(Expression expression) {
    _target = becomeParentOf(expression);
  }
  /**
   * Set the element associated with the operator to the given element.
   * @param element the element associated with this operator
   */
  void set element11(MethodElement element) {
    this._element = element;
  }
  /**
   * Set the expression used to compute the index to the given expression.
   * @param expression the expression used to compute the index
   */
  void set index2(Expression expression) {
    _index = becomeParentOf(expression);
  }
  /**
   * Set the left square bracket to the given token.
   * @param bracket the left square bracket
   */
  void set leftBracket4(Token bracket) {
    _leftBracket = bracket;
  }
  /**
   * Set the period ("..") before a cascaded index expression to the given token.
   * @param period the period ("..") before a cascaded index expression
   */
  void set period7(Token period) {
    this._period = period;
  }
  /**
   * Set the right square bracket to the given token.
   * @param bracket the right square bracket
   */
  void set rightBracket4(Token bracket) {
    _rightBracket = bracket;
  }
  void visitChildren(ASTVisitor<Object> visitor) {
    safelyVisitChild(_target, visitor);
    safelyVisitChild(_index, visitor);
  }
}
/**
 * Instances of the class {@code InstanceCreationExpression} represent an instance creation
 * expression.
 * <pre>
 * newExpression ::=
 * ('new' | 'const') {@link TypeName type} ('.' {@link SimpleIdentifier identifier})? {@link ArgumentList argumentList}</pre>
 */
class InstanceCreationExpression extends Expression {
  /**
   * The keyword used to indicate how an object should be created.
   */
  Token _keyword;
  /**
   * The name of the constructor to be invoked.
   */
  ConstructorName _constructorName;
  /**
   * The list of arguments to the constructor.
   */
  ArgumentList _argumentList;
  /**
   * The element associated with the constructor, or {@code null} if the AST structure has not been
   * resolved or if the constructor could not be resolved.
   */
  ConstructorElement _element;
  /**
   * Initialize a newly created instance creation expression.
   * @param keyword the keyword used to indicate how an object should be created
   * @param constructorName the name of the constructor to be invoked
   * @param argumentList the list of arguments to the constructor
   */
  InstanceCreationExpression(Token keyword, ConstructorName constructorName, ArgumentList argumentList) {
    this._keyword = keyword;
    this._constructorName = becomeParentOf(constructorName);
    this._argumentList = becomeParentOf(argumentList);
  }
  accept(ASTVisitor visitor) => visitor.visitInstanceCreationExpression(this);
  /**
   * Return the list of arguments to the constructor.
   * @return the list of arguments to the constructor
   */
  ArgumentList get argumentList => _argumentList;
  Token get beginToken => _keyword;
  /**
   * Return the name of the constructor to be invoked.
   * @return the name of the constructor to be invoked
   */
  ConstructorName get constructorName => _constructorName;
  /**
   * Return the element associated with the constructor, or {@code null} if the AST structure has
   * not been resolved or if the constructor could not be resolved.
   * @return the element associated with the constructor
   */
  ConstructorElement get element => _element;
  Token get endToken => _argumentList.endToken;
  /**
   * Return the keyword used to indicate how an object should be created.
   * @return the keyword used to indicate how an object should be created
   */
  Token get keyword => _keyword;
  /**
   * Set the list of arguments to the constructor to the given list.
   * @param argumentList the list of arguments to the constructor
   */
  void set argumentList6(ArgumentList argumentList) {
    this._argumentList = becomeParentOf(argumentList);
  }
  /**
   * Set the name of the constructor to be invoked to the given name.
   * @param constructorName the name of the constructor to be invoked
   */
  void set constructorName3(ConstructorName constructorName) {
    this._constructorName = constructorName;
  }
  /**
   * Set the element associated with the constructor to the given element.
   * @param element the element associated with the constructor
   */
  void set element12(ConstructorElement element) {
    this._element = element;
  }
  /**
   * Set the keyword used to indicate how an object should be created to the given keyword.
   * @param keyword the keyword used to indicate how an object should be created
   */
  void set keyword12(Token keyword) {
    this._keyword = keyword;
  }
  void visitChildren(ASTVisitor<Object> visitor) {
    safelyVisitChild(_constructorName, visitor);
    safelyVisitChild(_argumentList, visitor);
  }
}
/**
 * Instances of the class {@code IntegerLiteral} represent an integer literal expression.
 * <pre>
 * integerLiteral ::=
 * decimalIntegerLiteral
 * | hexidecimalIntegerLiteral
 * decimalIntegerLiteral ::=
 * decimalDigit+
 * hexidecimalIntegerLiteral ::=
 * '0x' hexidecimalDigit+
 * | '0X' hexidecimalDigit+
 * </pre>
 */
class IntegerLiteral extends Literal {
  /**
   * The token representing the literal.
   */
  Token _literal;
  /**
   * The value of the literal.
   */
  int _value = 0;
  /**
   * Initialize a newly created integer literal.
   * @param literal the token representing the literal
   * @param value the value of the literal
   */
  IntegerLiteral.con1(Token literal, int value) {
    _jtd_constructor_58_impl(literal, value);
  }
  _jtd_constructor_58_impl(Token literal, int value) {
    this._literal = literal;
    this._value = value;
  }
  /**
   * Initialize a newly created integer literal.
   * @param token the token representing the literal
   * @param value the value of the literal
   */
  IntegerLiteral.con2(Token token, int value) {
    _jtd_constructor_59_impl(token, value);
  }
  _jtd_constructor_59_impl(Token token, int value) {
    _jtd_constructor_58_impl(token, value);
  }
  accept(ASTVisitor visitor) => visitor.visitIntegerLiteral(this);
  Token get beginToken => _literal;
  Token get endToken => _literal;
  /**
   * Return the token representing the literal.
   * @return the token representing the literal
   */
  Token get literal => _literal;
  /**
   * Return the value of the literal.
   * @return the value of the literal
   */
  int get value => _value;
  /**
   * Set the token representing the literal to the given token.
   * @param literal the token representing the literal
   */
  void set literal4(Token literal) {
    this._literal = literal;
  }
  /**
   * Set the value of the literal to the given value.
   * @param value the value of the literal
   */
  void set value6(int value) {
    this._value = value;
  }
  void visitChildren(ASTVisitor<Object> visitor) {
  }
}
/**
 * The abstract class {@code InterpolationElement} defines the behavior common to elements within a{@link StringInterpolation string interpolation}.
 * <pre>
 * interpolationElement ::={@link InterpolationExpression interpolationExpression}| {@link InterpolationString interpolationString}</pre>
 */
abstract class InterpolationElement extends ASTNode {
}
/**
 * Instances of the class {@code InterpolationExpression} represent an expression embedded in a
 * string interpolation.
 * <pre>
 * interpolationExpression ::=
 * '$' {@link SimpleIdentifier identifier}| '$' '{' {@link Expression expression} '}'
 * </pre>
 */
class InterpolationExpression extends InterpolationElement {
  /**
   * The token used to introduce the interpolation expression; either '$' if the expression is a
   * simple identifier or '${' if the expression is a full expression.
   */
  Token _leftBracket;
  /**
   * The expression to be evaluated for the value to be converted into a string.
   */
  Expression _expression;
  /**
   * The right curly bracket, or {@code null} if the expression is an identifier without brackets.
   */
  Token _rightBracket;
  /**
   * Initialize a newly created interpolation expression.
   * @param leftBracket the left curly bracket
   * @param expression the expression to be evaluated for the value to be converted into a string
   * @param rightBracket the right curly bracket
   */
  InterpolationExpression(Token leftBracket, Expression expression, Token rightBracket) {
    this._leftBracket = leftBracket;
    this._expression = becomeParentOf(expression);
    this._rightBracket = rightBracket;
  }
  accept(ASTVisitor visitor) => visitor.visitInterpolationExpression(this);
  Token get beginToken => _leftBracket;
  Token get endToken {
    if (_rightBracket != null) {
      return _rightBracket;
    }
    return _expression.endToken;
  }
  /**
   * Return the expression to be evaluated for the value to be converted into a string.
   * @return the expression to be evaluated for the value to be converted into a string
   */
  Expression get expression => _expression;
  /**
   * Return the left curly bracket.
   * @return the left curly bracket
   */
  Token get leftBracket => _leftBracket;
  /**
   * Return the right curly bracket.
   * @return the right curly bracket
   */
  Token get rightBracket => _rightBracket;
  /**
   * Set the expression to be evaluated for the value to be converted into a string to the given
   * expression.
   * @param expression the expression to be evaluated for the value to be converted into a string
   */
  void set expression6(Expression expression) {
    this._expression = becomeParentOf(expression);
  }
  /**
   * Set the left curly bracket to the given token.
   * @param leftBracket the left curly bracket
   */
  void set leftBracket5(Token leftBracket) {
    this._leftBracket = leftBracket;
  }
  /**
   * Set the right curly bracket to the given token.
   * @param rightBracket the right curly bracket
   */
  void set rightBracket5(Token rightBracket) {
    this._rightBracket = rightBracket;
  }
  void visitChildren(ASTVisitor<Object> visitor) {
    safelyVisitChild(_expression, visitor);
  }
}
/**
 * Instances of the class {@code InterpolationString} represent a non-empty substring of an
 * interpolated string.
 * <pre>
 * interpolationString ::=
 * characters
 * </pre>
 */
class InterpolationString extends InterpolationElement {
  /**
   * The characters that will be added to the string.
   */
  Token _contents;
  /**
   * The value of the literal.
   */
  String _value;
  /**
   * Initialize a newly created string of characters that are part of a string interpolation.
   * @param the characters that will be added to the string
   * @param value the value of the literal
   */
  InterpolationString(Token contents, String value) {
    this._contents = contents;
    this._value = value;
  }
  accept(ASTVisitor visitor) => visitor.visitInterpolationString(this);
  Token get beginToken => _contents;
  /**
   * Return the characters that will be added to the string.
   * @return the characters that will be added to the string
   */
  Token get contents => _contents;
  Token get endToken => _contents;
  /**
   * Return the value of the literal.
   * @return the value of the literal
   */
  String get value => _value;
  /**
   * Set the characters that will be added to the string to those in the given string.
   * @param string the characters that will be added to the string
   */
  void set contents2(Token string) {
    _contents = string;
  }
  /**
   * Set the value of the literal to the given string.
   * @param string the value of the literal
   */
  void set value7(String string) {
    _value = string;
  }
  void visitChildren(ASTVisitor<Object> visitor) {
  }
}
/**
 * Instances of the class {@code IsExpression} represent an is expression.
 * <pre>
 * isExpression ::={@link Expression expression} 'is' '!'? {@link TypeName type}</pre>
 */
class IsExpression extends Expression {
  /**
   * The expression used to compute the value whose type is being tested.
   */
  Expression _expression;
  /**
   * The is operator.
   */
  Token _isOperator;
  /**
   * The not operator, or {@code null} if the sense of the test is not negated.
   */
  Token _notOperator;
  /**
   * The name of the type being tested for.
   */
  TypeName _type;
  /**
   * Initialize a newly created is expression.
   * @param expression the expression used to compute the value whose type is being tested
   * @param isOperator the is operator
   * @param notOperator the not operator, or {@code null} if the sense of the test is not negated
   * @param type the name of the type being tested for
   */
  IsExpression(Expression expression, Token isOperator, Token notOperator, TypeName type) {
    this._expression = becomeParentOf(expression);
    this._isOperator = isOperator;
    this._notOperator = notOperator;
    this._type = becomeParentOf(type);
  }
  accept(ASTVisitor visitor) => visitor.visitIsExpression(this);
  Token get beginToken => _expression.beginToken;
  Token get endToken => _type.endToken;
  /**
   * Return the expression used to compute the value whose type is being tested.
   * @return the expression used to compute the value whose type is being tested
   */
  Expression get expression => _expression;
  /**
   * Return the is operator being applied.
   * @return the is operator being applied
   */
  Token get isOperator => _isOperator;
  /**
   * Return the not operator being applied.
   * @return the not operator being applied
   */
  Token get notOperator => _notOperator;
  /**
   * Return the name of the type being tested for.
   * @return the name of the type being tested for
   */
  TypeName get type => _type;
  /**
   * Set the expression used to compute the value whose type is being tested to the given
   * expression.
   * @param expression the expression used to compute the value whose type is being tested
   */
  void set expression7(Expression expression) {
    this._expression = becomeParentOf(expression);
  }
  /**
   * Set the is operator being applied to the given operator.
   * @param isOperator the is operator being applied
   */
  void set isOperator2(Token isOperator) {
    this._isOperator = isOperator;
  }
  /**
   * Set the not operator being applied to the given operator.
   * @param notOperator the is operator being applied
   */
  void set notOperator2(Token notOperator) {
    this._notOperator = notOperator;
  }
  /**
   * Set the name of the type being tested for to the given name.
   * @param name the name of the type being tested for
   */
  void set type5(TypeName name) {
    this._type = becomeParentOf(name);
  }
  void visitChildren(ASTVisitor<Object> visitor) {
    safelyVisitChild(_expression, visitor);
    safelyVisitChild(_type, visitor);
  }
}
/**
 * Instances of the class {@code Label} represent a label.
 * <pre>
 * label ::={@link SimpleIdentifier label} ':'
 * </pre>
 */
class Label extends ASTNode {
  /**
   * The label being associated with the statement.
   */
  SimpleIdentifier _label;
  /**
   * The colon that separates the label from the statement.
   */
  Token _colon;
  /**
   * Initialize a newly created label.
   * @param label the label being applied
   * @param colon the colon that separates the label from whatever follows
   */
  Label(SimpleIdentifier label, Token colon) {
    this._label = becomeParentOf(label);
    this._colon = colon;
  }
  accept(ASTVisitor visitor) => visitor.visitLabel(this);
  Token get beginToken => _label.beginToken;
  /**
   * Return the colon that separates the label from the statement.
   * @return the colon that separates the label from the statement
   */
  Token get colon => _colon;
  Token get endToken => _colon;
  /**
   * Return the label being associated with the statement.
   * @return the label being associated with the statement
   */
  SimpleIdentifier get label => _label;
  /**
   * Set the colon that separates the label from the statement to the given token.
   * @param colon the colon that separates the label from the statement
   */
  void set colon3(Token colon) {
    this._colon = colon;
  }
  /**
   * Set the label being associated with the statement to the given label.
   * @param label the label being associated with the statement
   */
  void set label4(SimpleIdentifier label) {
    this._label = becomeParentOf(label);
  }
  void visitChildren(ASTVisitor<Object> visitor) {
    safelyVisitChild(_label, visitor);
  }
}
/**
 * Instances of the class {@code LabeledStatement} represent a statement that has a label associated
 * with them.
 * <pre>
 * labeledStatement ::={@link Label label}+ {@link Statement statement}</pre>
 */
class LabeledStatement extends Statement {
  /**
   * The labels being associated with the statement.
   */
  NodeList<Label> _labels;
  /**
   * The statement with which the labels are being associated.
   */
  Statement _statement;
  /**
   * Initialize a newly created labeled statement.
   * @param labels the labels being associated with the statement
   * @param statement the statement with which the labels are being associated
   */
  LabeledStatement(List<Label> labels, Statement statement) {
    this._labels = new NodeList<Label>(this);
    this._labels.addAll(labels);
    this._statement = becomeParentOf(statement);
  }
  accept(ASTVisitor visitor) => visitor.visitLabeledStatement(this);
  Token get beginToken {
    if (!_labels.isEmpty) {
      return _labels.beginToken;
    }
    return _statement.beginToken;
  }
  Token get endToken => _statement.endToken;
  /**
   * Return the labels being associated with the statement.
   * @return the labels being associated with the statement
   */
  NodeList<Label> get labels => _labels;
  /**
   * Return the statement with which the labels are being associated.
   * @return the statement with which the labels are being associated
   */
  Statement get statement => _statement;
  /**
   * Set the statement with which the labels are being associated to the given statement.
   * @param statement the statement with which the labels are being associated
   */
  void set statement2(Statement statement) {
    this._statement = becomeParentOf(statement);
  }
  void visitChildren(ASTVisitor<Object> visitor) {
    _labels.accept(visitor);
    safelyVisitChild(_statement, visitor);
  }
}
/**
 * Instances of the class {@code LibraryDirective} represent a library directive.
 * <pre>
 * libraryDirective ::={@link Annotation metadata} 'library' {@link Identifier name} ';'
 * </pre>
 */
class LibraryDirective extends Directive {
  /**
   * The token representing the 'library' token.
   */
  Token _libraryToken;
  /**
   * The name of the library being defined.
   */
  LibraryIdentifier _name;
  /**
   * The semicolon terminating the directive.
   */
  Token _semicolon;
  /**
   * Initialize a newly created library directive.
   * @param comment the documentation comment associated with this directive
   * @param metadata the annotations associated with the directive
   * @param libraryToken the token representing the 'library' token
   * @param name the name of the library being defined
   * @param semicolon the semicolon terminating the directive
   */
  LibraryDirective(Comment comment, List<Annotation> metadata, Token libraryToken, LibraryIdentifier name, Token semicolon) : super(comment, metadata) {
    this._libraryToken = libraryToken;
    this._name = becomeParentOf(name);
    this._semicolon = semicolon;
  }
  accept(ASTVisitor visitor) => visitor.visitLibraryDirective(this);
  Token get endToken => _semicolon;
  Token get keyword => _libraryToken;
  /**
   * Return the token representing the 'library' token.
   * @return the token representing the 'library' token
   */
  Token get libraryToken => _libraryToken;
  /**
   * Return the name of the library being defined.
   * @return the name of the library being defined
   */
  LibraryIdentifier get name => _name;
  /**
   * Return the semicolon terminating the directive.
   * @return the semicolon terminating the directive
   */
  Token get semicolon => _semicolon;
  /**
   * Set the token representing the 'library' token to the given token.
   * @param libraryToken the token representing the 'library' token
   */
  void set libraryToken2(Token libraryToken) {
    this._libraryToken = libraryToken;
  }
  /**
   * Set the name of the library being defined to the given name.
   * @param name the name of the library being defined
   */
  void set name9(LibraryIdentifier name) {
    this._name = becomeParentOf(name);
  }
  /**
   * Set the semicolon terminating the directive to the given token.
   * @param semicolon the semicolon terminating the directive
   */
  void set semicolon11(Token semicolon) {
    this._semicolon = semicolon;
  }
  void visitChildren(ASTVisitor<Object> visitor) {
    super.visitChildren(visitor);
    safelyVisitChild(_name, visitor);
  }
  Token get firstTokenAfterCommentAndMetadata => _libraryToken;
}
/**
 * Instances of the class {@code LibraryIdentifier} represent the identifier for a library.
 * <pre>
 * libraryIdentifier ::={@link SimpleIdentifier component} ('.' {@link SimpleIdentifier component})
 * </pre>
 */
class LibraryIdentifier extends Identifier {
  /**
   * The components of the identifier.
   */
  NodeList<SimpleIdentifier> _components;
  /**
   * Initialize a newly created prefixed identifier.
   * @param components the components of the identifier
   */
  LibraryIdentifier(List<SimpleIdentifier> components) {
    this._components = new NodeList<SimpleIdentifier>(this);
    this._components.addAll(components);
  }
  accept(ASTVisitor visitor) => visitor.visitLibraryIdentifier(this);
  Token get beginToken => _components.beginToken;
  /**
   * Return the components of the identifier.
   * @return the components of the identifier
   */
  NodeList<SimpleIdentifier> get components => _components;
  Token get endToken => _components.endToken;
  String get name {
    StringBuffer builder = new StringBuffer();
    bool needsPeriod = false;
    for (SimpleIdentifier identifier in _components) {
      if (needsPeriod) {
        builder.add(".");
      } else {
        needsPeriod = true;
      }
      builder.add(identifier.name);
    }
    return builder.toString();
  }
  void visitChildren(ASTVisitor<Object> visitor) {
    _components.accept(visitor);
  }
}
/**
 * Instances of the class {@code ListLiteral} represent a list literal.
 * <pre>
 * listLiteral ::=
 * 'const'? ('<' {@link TypeName type} '>')? '[' ({@link Expression expressionList} ','?)? ']'
 * </pre>
 */
class ListLiteral extends TypedLiteral {
  /**
   * The left square bracket.
   */
  Token _leftBracket;
  /**
   * The expressions used to compute the elements of the list.
   */
  NodeList<Expression> _elements;
  /**
   * The right square bracket.
   */
  Token _rightBracket;
  /**
   * Initialize a newly created list literal.
   * @param modifier the const modifier associated with this literal
   * @param typeArguments the type argument associated with this literal, or {@code null} if no type
   * arguments were declared
   * @param leftBracket the left square bracket
   * @param elements the expressions used to compute the elements of the list
   * @param rightBracket the right square bracket
   */
  ListLiteral(Token modifier, TypeArgumentList typeArguments, Token leftBracket, List<Expression> elements, Token rightBracket) : super(modifier, typeArguments) {
    this._elements = new NodeList<Expression>(this);
    this._leftBracket = leftBracket;
    this._elements.addAll(elements);
    this._rightBracket = rightBracket;
  }
  accept(ASTVisitor visitor) => visitor.visitListLiteral(this);
  Token get beginToken {
    Token token = modifier;
    if (token != null) {
      return token;
    }
    TypeArgumentList typeArguments6 = typeArguments;
    if (typeArguments6 != null) {
      return typeArguments6.beginToken;
    }
    return _leftBracket;
  }
  /**
   * Return the expressions used to compute the elements of the list.
   * @return the expressions used to compute the elements of the list
   */
  NodeList<Expression> get elements => _elements;
  Token get endToken => _rightBracket;
  /**
   * Return the left square bracket.
   * @return the left square bracket
   */
  Token get leftBracket => _leftBracket;
  /**
   * Return the right square bracket.
   * @return the right square bracket
   */
  Token get rightBracket => _rightBracket;
  /**
   * Set the left square bracket to the given token.
   * @param bracket the left square bracket
   */
  void set leftBracket6(Token bracket) {
    _leftBracket = bracket;
  }
  /**
   * Set the right square bracket to the given token.
   * @param bracket the right square bracket
   */
  void set rightBracket6(Token bracket) {
    _rightBracket = bracket;
  }
  void visitChildren(ASTVisitor<Object> visitor) {
    super.visitChildren(visitor);
    _elements.accept(visitor);
  }
}
/**
 * The abstract class {@code Literal} defines the behavior common to nodes that represent a literal
 * expression.
 * <pre>
 * literal ::={@link BooleanLiteral booleanLiteral}| {@link DoubleLiteral doubleLiteral}| {@link IntegerLiteral integerLiteral}| {@link ListLiteral listLiteral}| {@link MapLiteral mapLiteral}| {@link NullLiteral nullLiteral}| {@link StringLiteral stringLiteral}</pre>
 */
abstract class Literal extends Expression {
}
/**
 * Instances of the class {@code MapLiteral} represent a literal map.
 * <pre>
 * mapLiteral ::=
 * 'const'? ('<' {@link TypeName type} '>')? '{' ({@link MapLiteralEntry entry} (',' {@link MapLiteralEntry entry})* ','?)? '}'
 * </pre>
 */
class MapLiteral extends TypedLiteral {
  /**
   * The left curly bracket.
   */
  Token _leftBracket;
  /**
   * The entries in the map.
   */
  NodeList<MapLiteralEntry> _entries;
  /**
   * The right curly bracket.
   */
  Token _rightBracket;
  /**
   * Initialize a newly created map literal.
   * @param modifier the const modifier associated with this literal
   * @param typeArguments the type argument associated with this literal, or {@code null} if no type
   * arguments were declared
   * @param leftBracket the left curly bracket
   * @param entries the entries in the map
   * @param rightBracket the right curly bracket
   */
  MapLiteral(Token modifier, TypeArgumentList typeArguments, Token leftBracket, List<MapLiteralEntry> entries, Token rightBracket) : super(modifier, typeArguments) {
    this._entries = new NodeList<MapLiteralEntry>(this);
    this._leftBracket = leftBracket;
    this._entries.addAll(entries);
    this._rightBracket = rightBracket;
  }
  accept(ASTVisitor visitor) => visitor.visitMapLiteral(this);
  Token get beginToken {
    Token token = modifier;
    if (token != null) {
      return token;
    }
    TypeArgumentList typeArguments7 = typeArguments;
    if (typeArguments7 != null) {
      return typeArguments7.beginToken;
    }
    return _leftBracket;
  }
  Token get endToken => _rightBracket;
  /**
   * Return the entries in the map.
   * @return the entries in the map
   */
  NodeList<MapLiteralEntry> get entries => _entries;
  /**
   * Return the left curly bracket.
   * @return the left curly bracket
   */
  Token get leftBracket => _leftBracket;
  /**
   * Return the right curly bracket.
   * @return the right curly bracket
   */
  Token get rightBracket => _rightBracket;
  /**
   * Set the left curly bracket to the given token.
   * @param bracket the left curly bracket
   */
  void set leftBracket7(Token bracket) {
    _leftBracket = bracket;
  }
  /**
   * Set the right curly bracket to the given token.
   * @param bracket the right curly bracket
   */
  void set rightBracket7(Token bracket) {
    _rightBracket = bracket;
  }
  void visitChildren(ASTVisitor<Object> visitor) {
    super.visitChildren(visitor);
    _entries.accept(visitor);
  }
}
/**
 * Instances of the class {@code MapLiteralEntry} represent a single key/value pair in a map
 * literal.
 * <pre>
 * mapLiteralEntry ::={@link StringLiteral key} ':' {@link Expression value}</pre>
 */
class MapLiteralEntry extends ASTNode {
  /**
   * The key with which the value will be associated.
   */
  StringLiteral _key;
  /**
   * The colon that separates the key from the value.
   */
  Token _separator;
  /**
   * The expression computing the value that will be associated with the key.
   */
  Expression _value;
  /**
   * Initialize a newly created map literal entry.
   * @param key the key with which the value will be associated
   * @param separator the colon that separates the key from the value
   * @param value the expression computing the value that will be associated with the key
   */
  MapLiteralEntry(StringLiteral key, Token separator, Expression value) {
    this._key = becomeParentOf(key);
    this._separator = separator;
    this._value = becomeParentOf(value);
  }
  accept(ASTVisitor visitor) => visitor.visitMapLiteralEntry(this);
  Token get beginToken => _key.beginToken;
  Token get endToken => _value.endToken;
  /**
   * Return the key with which the value will be associated.
   * @return the key with which the value will be associated
   */
  StringLiteral get key => _key;
  /**
   * Return the colon that separates the key from the value.
   * @return the colon that separates the key from the value
   */
  Token get separator => _separator;
  /**
   * Return the expression computing the value that will be associated with the key.
   * @return the expression computing the value that will be associated with the key
   */
  Expression get value => _value;
  /**
   * Set the key with which the value will be associated to the given string.
   * @param string the key with which the value will be associated
   */
  void set key2(StringLiteral string) {
    _key = becomeParentOf(string);
  }
  /**
   * Set the colon that separates the key from the value to the given token.
   * @param separator the colon that separates the key from the value
   */
  void set separator4(Token separator) {
    this._separator = separator;
  }
  /**
   * Set the expression computing the value that will be associated with the key to the given
   * expression.
   * @param expression the expression computing the value that will be associated with the key
   */
  void set value8(Expression expression) {
    _value = becomeParentOf(expression);
  }
  void visitChildren(ASTVisitor<Object> visitor) {
    safelyVisitChild(_key, visitor);
    safelyVisitChild(_value, visitor);
  }
}
/**
 * Instances of the class {@code MethodDeclaration} represent a method declaration.
 * <pre>
 * methodDeclaration ::=
 * methodSignature {@link FunctionBody body}methodSignature ::=
 * 'external'? ('abstract' | 'static')? {@link Type returnType}? ('get' | 'set')? methodName{@link FormalParameterList formalParameterList}methodName ::={@link SimpleIdentifier name} ('.' {@link SimpleIdentifier name})?
 * | 'operator' {@link SimpleIdentifier operator}</pre>
 */
class MethodDeclaration extends ClassMember {
  /**
   * The token for the 'external' keyword, or {@code null} if the constructor is not external.
   */
  Token _externalKeyword;
  /**
   * The token representing the 'abstract' or 'static' keyword, or {@code null} if neither modifier
   * was specified.
   */
  Token _modifierKeyword;
  /**
   * The return type of the method, or {@code null} if no return type was declared.
   */
  TypeName _returnType;
  /**
   * The token representing the 'get' or 'set' keyword, or {@code null} if this is a method
   * declaration rather than a property declaration.
   */
  Token _propertyKeyword;
  /**
   * The token representing the 'operator' keyword, or {@code null} if this method does not declare
   * an operator.
   */
  Token _operatorKeyword;
  /**
   * The name of the method.
   */
  Identifier _name;
  /**
   * The parameters associated with the method, or {@code null} if this method declares a getter.
   */
  FormalParameterList _parameters;
  /**
   * The body of the method.
   */
  FunctionBody _body;
  /**
   * Initialize a newly created method declaration.
   * @param externalKeyword the token for the 'external' keyword
   * @param comment the documentation comment associated with this method
   * @param metadata the annotations associated with this method
   * @param modifierKeyword the token representing the 'abstract' or 'static' keyword
   * @param returnType the return type of the method
   * @param propertyKeyword the token representing the 'get' or 'set' keyword
   * @param operatorKeyword the token representing the 'operator' keyword
   * @param name the name of the method
   * @param parameters the parameters associated with the method, or {@code null} if this method
   * declares a getter
   * @param body the body of the method
   */
  MethodDeclaration(Comment comment, List<Annotation> metadata, Token externalKeyword, Token modifierKeyword, TypeName returnType, Token propertyKeyword, Token operatorKeyword, Identifier name, FormalParameterList parameters, FunctionBody body) : super(comment, metadata) {
    this._externalKeyword = externalKeyword;
    this._modifierKeyword = modifierKeyword;
    this._returnType = becomeParentOf(returnType);
    this._propertyKeyword = propertyKeyword;
    this._operatorKeyword = operatorKeyword;
    this._name = becomeParentOf(name);
    this._parameters = becomeParentOf(parameters);
    this._body = becomeParentOf(body);
  }
  accept(ASTVisitor visitor) => visitor.visitMethodDeclaration(this);
  /**
   * Return the body of the method.
   * @return the body of the method
   */
  FunctionBody get body => _body;
  /**
   * Return the element associated with this method, or {@code null} if the AST structure has not
   * been resolved. The element can either be a {@link MethodElement}, if this represents the
   * declaration of a normal method, or a {@link PropertyAccessorElement} if this represents the
   * declaration of either a getter or a setter.
   * @return the element associated with this method
   */
  ExecutableElement get element => _name != null ? _name.element as ExecutableElement : null;
  Token get endToken => _body.endToken;
  /**
   * Return the token for the 'external' keyword, or {@code null} if the constructor is not
   * external.
   * @return the token for the 'external' keyword
   */
  Token get externalKeyword => _externalKeyword;
  /**
   * Return the token representing the 'abstract' or 'static' keyword, or {@code null} if neither
   * modifier was specified.
   * @return the token representing the 'abstract' or 'static' keyword
   */
  Token get modifierKeyword => _modifierKeyword;
  /**
   * Return the name of the method.
   * @return the name of the method
   */
  Identifier get name => _name;
  /**
   * Return the token representing the 'operator' keyword, or {@code null} if this method does not
   * declare an operator.
   * @return the token representing the 'operator' keyword
   */
  Token get operatorKeyword => _operatorKeyword;
  /**
   * Return the parameters associated with the method, or {@code null} if this method declares a
   * getter.
   * @return the parameters associated with the method
   */
  FormalParameterList get parameters => _parameters;
  /**
   * Return the token representing the 'get' or 'set' keyword, or {@code null} if this is a method
   * declaration rather than a property declaration.
   * @return the token representing the 'get' or 'set' keyword
   */
  Token get propertyKeyword => _propertyKeyword;
  /**
   * Return the return type of the method, or {@code null} if no return type was declared.
   * @return the return type of the method
   */
  TypeName get returnType => _returnType;
  /**
   * Return {@code true} if this method declares a getter.
   * @return {@code true} if this method declares a getter
   */
  bool isGetter() => _propertyKeyword != null && (_propertyKeyword as KeywordToken).keyword == Keyword.GET;
  /**
   * Return {@code true} if this method declares an operator.
   * @return {@code true} if this method declares an operator
   */
  bool isOperator() => _operatorKeyword != null;
  /**
   * Return {@code true} if this method declares a setter.
   * @return {@code true} if this method declares a setter
   */
  bool isSetter() => _propertyKeyword != null && (_propertyKeyword as KeywordToken).keyword == Keyword.SET;
  /**
   * Set the body of the method to the given function body.
   * @param functionBody the body of the method
   */
  void set body8(FunctionBody functionBody) {
    _body = becomeParentOf(functionBody);
  }
  /**
   * Set the token for the 'external' keyword to the given token.
   * @param externalKeyword the token for the 'external' keyword
   */
  void set externalKeyword4(Token externalKeyword) {
    this._externalKeyword = externalKeyword;
  }
  /**
   * Set the token representing the 'abstract' or 'static' keyword to the given token.
   * @param modifierKeyword the token representing the 'abstract' or 'static' keyword
   */
  void set modifierKeyword2(Token modifierKeyword) {
    this._modifierKeyword = modifierKeyword;
  }
  /**
   * Set the name of the method to the given identifier.
   * @param identifier the name of the method
   */
  void set name10(Identifier identifier) {
    _name = becomeParentOf(identifier);
  }
  /**
   * Set the token representing the 'operator' keyword to the given token.
   * @param operatorKeyword the token representing the 'operator' keyword
   */
  void set operatorKeyword2(Token operatorKeyword) {
    this._operatorKeyword = operatorKeyword;
  }
  /**
   * Set the parameters associated with the method to the given list of parameters.
   * @param parameters the parameters associated with the method
   */
  void set parameters6(FormalParameterList parameters) {
    this._parameters = becomeParentOf(parameters);
  }
  /**
   * Set the token representing the 'get' or 'set' keyword to the given token.
   * @param propertyKeyword the token representing the 'get' or 'set' keyword
   */
  void set propertyKeyword3(Token propertyKeyword) {
    this._propertyKeyword = propertyKeyword;
  }
  /**
   * Set the return type of the method to the given type name.
   * @param typeName the return type of the method
   */
  void set returnType6(TypeName typeName) {
    _returnType = becomeParentOf(typeName);
  }
  void visitChildren(ASTVisitor<Object> visitor) {
    super.visitChildren(visitor);
    safelyVisitChild(_returnType, visitor);
    safelyVisitChild(_name, visitor);
    safelyVisitChild(_parameters, visitor);
    safelyVisitChild(_body, visitor);
  }
  Token get firstTokenAfterCommentAndMetadata {
    if (_modifierKeyword != null) {
      return _modifierKeyword;
    } else if (_returnType != null) {
      return _returnType.beginToken;
    } else if (_propertyKeyword != null) {
      return _propertyKeyword;
    } else if (_operatorKeyword != null) {
      return _operatorKeyword;
    }
    return _name.beginToken;
  }
}
/**
 * Instances of the class {@code MethodInvocation} represent the invocation of either a function or
 * a method. Invocations of functions resulting from evaluating an expression are represented by{@link FunctionExpressionInvocation function expression invocation} nodes. Invocations of getters
 * and setters are represented by either {@link PrefixedIdentifier prefixed identifier} or{@link PropertyAccess property access} nodes.
 * <pre>
 * methodInvoction ::=
 * ({@link Expression target} '.')? {@link SimpleIdentifier methodName} {@link ArgumentList argumentList}</pre>
 */
class MethodInvocation extends Expression {
  /**
   * The expression producing the object on which the method is defined, or {@code null} if there is
   * no target (that is, the target is implicitly {@code this}).
   */
  Expression _target;
  /**
   * The period that separates the target from the method name, or {@code null} if there is no
   * target.
   */
  Token _period;
  /**
   * The name of the method being invoked.
   */
  SimpleIdentifier _methodName;
  /**
   * The list of arguments to the method.
   */
  ArgumentList _argumentList;
  /**
   * Initialize a newly created method invocation.
   * @param target the expression producing the object on which the method is defined
   * @param period the period that separates the target from the method name
   * @param methodName the name of the method being invoked
   * @param argumentList the list of arguments to the method
   */
  MethodInvocation(Expression target, Token period, SimpleIdentifier methodName, ArgumentList argumentList) {
    this._target = becomeParentOf(target);
    this._period = period;
    this._methodName = becomeParentOf(methodName);
    this._argumentList = becomeParentOf(argumentList);
  }
  accept(ASTVisitor visitor) => visitor.visitMethodInvocation(this);
  /**
   * Return the list of arguments to the method.
   * @return the list of arguments to the method
   */
  ArgumentList get argumentList => _argumentList;
  Token get beginToken {
    if (_target != null) {
      return _target.beginToken;
    }
    return _methodName.beginToken;
  }
  Token get endToken => _argumentList.endToken;
  /**
   * Return the name of the method being invoked.
   * @return the name of the method being invoked
   */
  SimpleIdentifier get methodName => _methodName;
  /**
   * Return the period that separates the target from the method name, or {@code null} if there is
   * no target.
   * @return the period that separates the target from the method name
   */
  Token get period => _period;
  /**
   * Return the expression used to compute the receiver of the invocation. If this invocation is not
   * part of a cascade expression, then this is the same as {@link #getTarget()}. If this invocation
   * is part of a cascade expression, then the target stored with the cascade expression is
   * returned.
   * @return the expression used to compute the receiver of the invocation
   * @see #getTarget()
   */
  Expression get realTarget {
    if (isCascaded()) {
      ASTNode ancestor = parent;
      while (ancestor is! CascadeExpression) {
        if (ancestor == null) {
          return _target;
        }
        ancestor = ancestor.parent;
      }
      return (ancestor as CascadeExpression).target;
    }
    return _target;
  }
  /**
   * Return the expression producing the object on which the method is defined, or {@code null} if
   * there is no target (that is, the target is implicitly {@code this}) or if this method
   * invocation is part of a cascade expression.
   * @return the expression producing the object on which the method is defined
   * @see #getRealTarget()
   */
  Expression get target => _target;
  /**
   * Return {@code true} if this expression is cascaded. If it is, then the target of this
   * expression is not stored locally but is stored in the nearest ancestor that is a{@link CascadeExpression}.
   * @return {@code true} if this expression is cascaded
   */
  bool isCascaded() => _period != null && _period.type == TokenType.PERIOD_PERIOD;
  /**
   * Set the list of arguments to the method to the given list.
   * @param argumentList the list of arguments to the method
   */
  void set argumentList7(ArgumentList argumentList) {
    this._argumentList = becomeParentOf(argumentList);
  }
  /**
   * Set the name of the method being invoked to the given identifier.
   * @param identifier the name of the method being invoked
   */
  void set methodName2(SimpleIdentifier identifier) {
    _methodName = becomeParentOf(identifier);
  }
  /**
   * Set the period that separates the target from the method name to the given token.
   * @param period the period that separates the target from the method name
   */
  void set period8(Token period) {
    this._period = period;
  }
  /**
   * Set the expression producing the object on which the method is defined to the given expression.
   * @param expression the expression producing the object on which the method is defined
   */
  void set target3(Expression expression) {
    _target = becomeParentOf(expression);
  }
  void visitChildren(ASTVisitor<Object> visitor) {
    safelyVisitChild(_target, visitor);
    safelyVisitChild(_methodName, visitor);
    safelyVisitChild(_argumentList, visitor);
  }
}
/**
 * Instances of the class {@code NamedExpression} represent an expression that has a name associated
 * with it. They are used in method invocations when there are named parameters.
 * <pre>
 * namedExpression ::={@link Label name} {@link Expression expression}</pre>
 */
class NamedExpression extends Expression {
  /**
   * The name associated with the expression.
   */
  Label _name;
  /**
   * The expression with which the name is associated.
   */
  Expression _expression;
  /**
   * Initialize a newly created named expression.
   * @param name the name associated with the expression
   * @param expression the expression with which the name is associated
   */
  NamedExpression(Label name, Expression expression) {
    this._name = becomeParentOf(name);
    this._expression = becomeParentOf(expression);
  }
  accept(ASTVisitor visitor) => visitor.visitNamedExpression(this);
  Token get beginToken => _name.beginToken;
  Token get endToken => _expression.endToken;
  /**
   * Return the expression with which the name is associated.
   * @return the expression with which the name is associated
   */
  Expression get expression => _expression;
  /**
   * Return the name associated with the expression.
   * @return the name associated with the expression
   */
  Label get name => _name;
  /**
   * Set the expression with which the name is associated to the given expression.
   * @param expression the expression with which the name is associated
   */
  void set expression8(Expression expression) {
    this._expression = becomeParentOf(expression);
  }
  /**
   * Set the name associated with the expression to the given identifier.
   * @param identifier the name associated with the expression
   */
  void set name11(Label identifier) {
    _name = becomeParentOf(identifier);
  }
  void visitChildren(ASTVisitor<Object> visitor) {
    safelyVisitChild(_name, visitor);
    safelyVisitChild(_expression, visitor);
  }
}
/**
 * The abstract class {@code NamespaceDirective} defines the behavior common to nodes that represent
 * a directive that impacts the namespace of a library.
 * <pre>
 * directive ::={@link ExportDirective exportDirective}| {@link ImportDirective importDirective}</pre>
 */
abstract class NamespaceDirective extends Directive {
  /**
   * The token representing the 'import' or 'export' keyword.
   */
  Token _keyword;
  /**
   * The URI of the library being imported or exported.
   */
  StringLiteral _libraryUri;
  /**
   * The combinators used to control which names are imported or exported.
   */
  NodeList<Combinator> _combinators;
  /**
   * The semicolon terminating the directive.
   */
  Token _semicolon;
  /**
   * Initialize a newly created namespace directive.
   * @param comment the documentation comment associated with this directive
   * @param metadata the annotations associated with the directive
   * @param keyword the token representing the 'import' or 'export' keyword
   * @param libraryUri the URI of the library being imported or exported
   * @param combinators the combinators used to control which names are imported or exported
   * @param semicolon the semicolon terminating the directive
   */
  NamespaceDirective(Comment comment, List<Annotation> metadata, Token keyword, StringLiteral libraryUri, List<Combinator> combinators, Token semicolon) : super(comment, metadata) {
    this._combinators = new NodeList<Combinator>(this);
    this._keyword = keyword;
    this._libraryUri = becomeParentOf(libraryUri);
    this._combinators.addAll(combinators);
    this._semicolon = semicolon;
  }
  /**
   * Return the combinators used to control how names are imported or exported.
   * @return the combinators used to control how names are imported or exported
   */
  NodeList<Combinator> get combinators => _combinators;
  Token get endToken => _semicolon;
  Token get keyword => _keyword;
  /**
   * Return the URI of the library being imported or exported.
   * @return the URI of the library being imported or exported
   */
  StringLiteral get libraryUri => _libraryUri;
  /**
   * Return the semicolon terminating the directive.
   * @return the semicolon terminating the directive
   */
  Token get semicolon => _semicolon;
  /**
   * Set the token representing the 'import' or 'export' keyword to the given token.
   * @param exportToken the token representing the 'import' or 'export' keyword
   */
  void set keyword13(Token exportToken) {
    this._keyword = exportToken;
  }
  /**
   * Set the URI of the library being imported or exported to the given literal.
   * @param literal the URI of the library being imported or exported
   */
  void set libraryUri2(StringLiteral literal) {
    _libraryUri = becomeParentOf(literal);
  }
  /**
   * Set the semicolon terminating the directive to the given token.
   * @param semicolon the semicolon terminating the directive
   */
  void set semicolon12(Token semicolon) {
    this._semicolon = semicolon;
  }
  Token get firstTokenAfterCommentAndMetadata => _keyword;
}
/**
 * The abstract class {@code NormalFormalParameter} defines the behavior common to formal parameters
 * that are required (are not optional).
 * <pre>
 * normalFormalParameter ::={@link FunctionTypedFormalParameter functionSignature}| {@link FieldFormalParameter fieldFormalParameter}| {@link SimpleFormalParameter simpleFormalParameter}</pre>
 */
abstract class NormalFormalParameter extends FormalParameter {
  /**
   * The documentation comment associated with this parameter, or {@code null} if this parameter
   * does not have a documentation comment associated with it.
   */
  Comment _comment;
  /**
   * The annotations associated with this parameter.
   */
  NodeList<Annotation> _metadata;
  /**
   * The name of the parameter being declared.
   */
  SimpleIdentifier _identifier;
  /**
   * Initialize a newly created formal parameter.
   * @param comment the documentation comment associated with this parameter
   * @param metadata the annotations associated with this parameter
   * @param identifier the name of the parameter being declared
   */
  NormalFormalParameter(Comment comment, List<Annotation> metadata, SimpleIdentifier identifier) {
    this._metadata = new NodeList<Annotation>(this);
    this._comment = becomeParentOf(comment);
    this._metadata.addAll(metadata);
    this._identifier = becomeParentOf(identifier);
  }
  /**
   * Return the documentation comment associated with this parameter, or {@code null} if this
   * parameter does not have a documentation comment associated with it.
   * @return the documentation comment associated with this parameter
   */
  Comment get documentationComment => _comment;
  SimpleIdentifier get identifier => _identifier;
  ParameterKind get kind {
    ASTNode parent6 = parent;
    if (parent6 is DefaultFormalParameter) {
      return (parent6 as DefaultFormalParameter).kind;
    }
    return ParameterKind.REQUIRED;
  }
  /**
   * Return the annotations associated with this parameter.
   * @return the annotations associated with this parameter
   */
  NodeList<Annotation> get metadata => _metadata;
  /**
   * Return {@code true} if this parameter is a const parameter.
   * @return {@code true} if this parameter is a const parameter
   */
  bool isConst();
  /**
   * Return {@code true} if this parameter is a final parameter.
   * @return {@code true} if this parameter is a final parameter
   */
  bool isFinal();
  /**
   * Set the documentation comment associated with this parameter to the given comment
   * @param comment the documentation comment to be associated with this parameter
   */
  void set documentationComment(Comment comment) {
    this._comment = becomeParentOf(comment);
  }
  /**
   * Set the name of the parameter being declared to the given identifier.
   * @param identifier the name of the parameter being declared
   */
  void set identifier4(SimpleIdentifier identifier) {
    this._identifier = becomeParentOf(identifier);
  }
  void visitChildren(ASTVisitor<Object> visitor) {
    if (commentIsBeforeAnnotations()) {
      safelyVisitChild(_comment, visitor);
      _metadata.accept(visitor);
    } else {
      for (ASTNode child in sortedCommentAndAnnotations) {
        child.accept(visitor);
      }
    }
  }
  /**
   * Return {@code true} if the comment is lexically before any annotations.
   * @return {@code true} if the comment is lexically before any annotations
   */
  bool commentIsBeforeAnnotations() {
    if (_comment == null || _metadata.isEmpty) {
      return true;
    }
    Annotation firstAnnotation = _metadata[0];
    return _comment.offset < firstAnnotation.offset;
  }
  /**
   * Return an array containing the comment and annotations associated with this parameter, sorted
   * in lexical order.
   * @return the comment and annotations associated with this parameter in the order in which they
   * appeared in the original source
   */
  List<ASTNode> get sortedCommentAndAnnotations {
    List<ASTNode> childList = new List<ASTNode>();
    childList.add(_comment);
    childList.addAll(_metadata);
    List<ASTNode> children = new List.from(childList);
    children.sort();
    return children;
  }
}
/**
 * Instances of the class {@code NullLiteral} represent a null literal expression.
 * <pre>
 * nullLiteral ::=
 * 'null'
 * </pre>
 */
class NullLiteral extends Literal {
  /**
   * The token representing the literal.
   */
  Token _literal;
  /**
   * Initialize a newly created null literal.
   * @param token the token representing the literal
   */
  NullLiteral(Token token) {
    this._literal = token;
  }
  accept(ASTVisitor visitor) => visitor.visitNullLiteral(this);
  Token get beginToken => _literal;
  Token get endToken => _literal;
  /**
   * Return the token representing the literal.
   * @return the token representing the literal
   */
  Token get literal => _literal;
  /**
   * Set the token representing the literal to the given token.
   * @param literal the token representing the literal
   */
  void set literal5(Token literal) {
    this._literal = literal;
  }
  void visitChildren(ASTVisitor<Object> visitor) {
  }
}
/**
 * Instances of the class {@code ParenthesizedExpression} represent a parenthesized expression.
 * <pre>
 * parenthesizedExpression ::=
 * '(' {@link Expression expression} ')'
 * </pre>
 */
class ParenthesizedExpression extends Expression {
  /**
   * The left parenthesis.
   */
  Token _leftParenthesis;
  /**
   * The expression within the parentheses.
   */
  Expression _expression;
  /**
   * The right parenthesis.
   */
  Token _rightParenthesis;
  /**
   * Initialize a newly created parenthesized expression.
   * @param leftParenthesis the left parenthesis
   * @param expression the expression within the parentheses
   * @param rightParenthesis the right parenthesis
   */
  ParenthesizedExpression(Token leftParenthesis, Expression expression, Token rightParenthesis) {
    this._leftParenthesis = leftParenthesis;
    this._expression = becomeParentOf(expression);
    this._rightParenthesis = rightParenthesis;
  }
  accept(ASTVisitor visitor) => visitor.visitParenthesizedExpression(this);
  Token get beginToken => _leftParenthesis;
  Token get endToken => _rightParenthesis;
  /**
   * Return the expression within the parentheses.
   * @return the expression within the parentheses
   */
  Expression get expression => _expression;
  /**
   * Return the left parenthesis.
   * @return the left parenthesis
   */
  Token get leftParenthesis => _leftParenthesis;
  /**
   * Return the right parenthesis.
   * @return the right parenthesis
   */
  Token get rightParenthesis => _rightParenthesis;
  /**
   * Set the expression within the parentheses to the given expression.
   * @param expression the expression within the parentheses
   */
  void set expression9(Expression expression) {
    this._expression = becomeParentOf(expression);
  }
  /**
   * Set the left parenthesis to the given token.
   * @param parenthesis the left parenthesis
   */
  void set leftParenthesis10(Token parenthesis) {
    _leftParenthesis = parenthesis;
  }
  /**
   * Set the right parenthesis to the given token.
   * @param parenthesis the right parenthesis
   */
  void set rightParenthesis10(Token parenthesis) {
    _rightParenthesis = parenthesis;
  }
  void visitChildren(ASTVisitor<Object> visitor) {
    safelyVisitChild(_expression, visitor);
  }
}
/**
 * Instances of the class {@code PartDirective} represent a part directive.
 * <pre>
 * partDirective ::={@link Annotation metadata} 'part' {@link StringLiteral partUri} ';'
 * </pre>
 */
class PartDirective extends Directive {
  /**
   * The token representing the 'part' token.
   */
  Token _partToken;
  /**
   * The URI of the part being included.
   */
  StringLiteral _partUri;
  /**
   * The semicolon terminating the directive.
   */
  Token _semicolon;
  /**
   * Initialize a newly created part directive.
   * @param comment the documentation comment associated with this directive
   * @param metadata the annotations associated with the directive
   * @param partToken the token representing the 'part' token
   * @param partUri the URI of the part being included
   * @param semicolon the semicolon terminating the directive
   */
  PartDirective(Comment comment, List<Annotation> metadata, Token partToken, StringLiteral partUri, Token semicolon) : super(comment, metadata) {
    this._partToken = partToken;
    this._partUri = becomeParentOf(partUri);
    this._semicolon = semicolon;
  }
  accept(ASTVisitor visitor) => visitor.visitPartDirective(this);
  Token get endToken => _semicolon;
  Token get keyword => _partToken;
  /**
   * Return the token representing the 'part' token.
   * @return the token representing the 'part' token
   */
  Token get partToken => _partToken;
  /**
   * Return the URI of the part being included.
   * @return the URI of the part being included
   */
  StringLiteral get partUri => _partUri;
  /**
   * Return the semicolon terminating the directive.
   * @return the semicolon terminating the directive
   */
  Token get semicolon => _semicolon;
  /**
   * Set the token representing the 'part' token to the given token.
   * @param partToken the token representing the 'part' token
   */
  void set partToken2(Token partToken) {
    this._partToken = partToken;
  }
  /**
   * Set the URI of the part being included to the given string.
   * @param partUri the URI of the part being included
   */
  void set partUri2(StringLiteral partUri) {
    this._partUri = becomeParentOf(partUri);
  }
  /**
   * Set the semicolon terminating the directive to the given token.
   * @param semicolon the semicolon terminating the directive
   */
  void set semicolon13(Token semicolon) {
    this._semicolon = semicolon;
  }
  void visitChildren(ASTVisitor<Object> visitor) {
    super.visitChildren(visitor);
    safelyVisitChild(_partUri, visitor);
  }
  Token get firstTokenAfterCommentAndMetadata => _partToken;
}
/**
 * Instances of the class {@code PartOfDirective} represent a part-of directive.
 * <pre>
 * partOfDirective ::={@link Annotation metadata} 'part' 'of' {@link Identifier libraryName} ';'
 * </pre>
 */
class PartOfDirective extends Directive {
  /**
   * The token representing the 'part' token.
   */
  Token _partToken;
  /**
   * The token representing the 'of' token.
   */
  Token _ofToken;
  /**
   * The name of the library that the containing compilation unit is part of.
   */
  LibraryIdentifier _libraryName;
  /**
   * The semicolon terminating the directive.
   */
  Token _semicolon;
  /**
   * Initialize a newly created part-of directive.
   * @param comment the documentation comment associated with this directive
   * @param metadata the annotations associated with the directive
   * @param partToken the token representing the 'part' token
   * @param ofToken the token representing the 'of' token
   * @param libraryName the name of the library that the containing compilation unit is part of
   * @param semicolon the semicolon terminating the directive
   */
  PartOfDirective(Comment comment, List<Annotation> metadata, Token partToken, Token ofToken, LibraryIdentifier libraryName, Token semicolon) : super(comment, metadata) {
    this._partToken = partToken;
    this._ofToken = ofToken;
    this._libraryName = becomeParentOf(libraryName);
    this._semicolon = semicolon;
  }
  accept(ASTVisitor visitor) => visitor.visitPartOfDirective(this);
  Token get endToken => _semicolon;
  Token get keyword => _partToken;
  /**
   * Return the name of the library that the containing compilation unit is part of.
   * @return the name of the library that the containing compilation unit is part of
   */
  LibraryIdentifier get libraryName => _libraryName;
  /**
   * Return the token representing the 'of' token.
   * @return the token representing the 'of' token
   */
  Token get ofToken => _ofToken;
  /**
   * Return the token representing the 'part' token.
   * @return the token representing the 'part' token
   */
  Token get partToken => _partToken;
  /**
   * Return the semicolon terminating the directive.
   * @return the semicolon terminating the directive
   */
  Token get semicolon => _semicolon;
  /**
   * Set the name of the library that the containing compilation unit is part of to the given name.
   * @param libraryName the name of the library that the containing compilation unit is part of
   */
  void set libraryName2(LibraryIdentifier libraryName) {
    this._libraryName = becomeParentOf(libraryName);
  }
  /**
   * Set the token representing the 'of' token to the given token.
   * @param ofToken the token representing the 'of' token
   */
  void set ofToken2(Token ofToken) {
    this._ofToken = ofToken;
  }
  /**
   * Set the token representing the 'part' token to the given token.
   * @param partToken the token representing the 'part' token
   */
  void set partToken3(Token partToken) {
    this._partToken = partToken;
  }
  /**
   * Set the semicolon terminating the directive to the given token.
   * @param semicolon the semicolon terminating the directive
   */
  void set semicolon14(Token semicolon) {
    this._semicolon = semicolon;
  }
  void visitChildren(ASTVisitor<Object> visitor) {
    super.visitChildren(visitor);
    safelyVisitChild(_libraryName, visitor);
  }
  Token get firstTokenAfterCommentAndMetadata => _partToken;
}
/**
 * Instances of the class {@code PostfixExpression} represent a postfix unary expression.
 * <pre>
 * postfixExpression ::={@link Expression operand} {@link Token operator}</pre>
 */
class PostfixExpression extends Expression {
  /**
   * The expression computing the operand for the operator.
   */
  Expression _operand;
  /**
   * The postfix operator being applied to the operand.
   */
  Token _operator;
  /**
   * The element associated with this the operator, or {@code null} if the AST structure has not
   * been resolved, if the operator is not user definable, or if the operator could not be resolved.
   */
  MethodElement _element;
  /**
   * Initialize a newly created postfix expression.
   * @param operand the expression computing the operand for the operator
   * @param operator the postfix operator being applied to the operand
   */
  PostfixExpression(Expression operand, Token operator) {
    this._operand = becomeParentOf(operand);
    this._operator = operator;
  }
  accept(ASTVisitor visitor) => visitor.visitPostfixExpression(this);
  Token get beginToken => _operand.beginToken;
  /**
   * Return the element associated with the operator, or {@code null} if the AST structure has not
   * been resolved, if the operator is not user definable, or if the operator could not be resolved.
   * One example of the latter case is an operator that is not defined for the type of the operand.
   * @return the element associated with the operator
   */
  MethodElement get element => _element;
  Token get endToken => _operator;
  /**
   * Return the expression computing the operand for the operator.
   * @return the expression computing the operand for the operator
   */
  Expression get operand => _operand;
  /**
   * Return the postfix operator being applied to the operand.
   * @return the postfix operator being applied to the operand
   */
  Token get operator => _operator;
  /**
   * Set the element associated with the operator to the given element.
   * @param element the element associated with the operator
   */
  void set element13(MethodElement element) {
    this._element = element;
  }
  /**
   * Set the expression computing the operand for the operator to the given expression.
   * @param expression the expression computing the operand for the operator
   */
  void set operand2(Expression expression) {
    _operand = becomeParentOf(expression);
  }
  /**
   * Set the postfix operator being applied to the operand to the given operator.
   * @param operator the postfix operator being applied to the operand
   */
  void set operator4(Token operator) {
    this._operator = operator;
  }
  void visitChildren(ASTVisitor<Object> visitor) {
    safelyVisitChild(_operand, visitor);
  }
}
/**
 * Instances of the class {@code PrefixExpression} represent a prefix unary expression.
 * <pre>
 * prefixExpression ::={@link Token operator} {@link Expression operand}</pre>
 */
class PrefixExpression extends Expression {
  /**
   * The prefix operator being applied to the operand.
   */
  Token _operator;
  /**
   * The expression computing the operand for the operator.
   */
  Expression _operand;
  /**
   * The element associated with the operator, or {@code null} if the AST structure has not been
   * resolved, if the operator is not user definable, or if the operator could not be resolved.
   */
  MethodElement _element;
  /**
   * Initialize a newly created prefix expression.
   * @param operator the prefix operator being applied to the operand
   * @param operand the expression computing the operand for the operator
   */
  PrefixExpression(Token operator, Expression operand) {
    this._operator = operator;
    this._operand = becomeParentOf(operand);
  }
  accept(ASTVisitor visitor) => visitor.visitPrefixExpression(this);
  Token get beginToken => _operator;
  /**
   * Return the element associated with the operator, or {@code null} if the AST structure has not
   * been resolved, if the operator is not user definable, or if the operator could not be resolved.
   * One example of the latter case is an operator that is not defined for the type of the operand.
   * @return the element associated with the operator
   */
  MethodElement get element => _element;
  Token get endToken => _operand.endToken;
  /**
   * Return the expression computing the operand for the operator.
   * @return the expression computing the operand for the operator
   */
  Expression get operand => _operand;
  /**
   * Return the prefix operator being applied to the operand.
   * @return the prefix operator being applied to the operand
   */
  Token get operator => _operator;
  /**
   * Set the element associated with the operator to the given element.
   * @param element the element associated with the operator
   */
  void set element14(MethodElement element) {
    this._element = element;
  }
  /**
   * Set the expression computing the operand for the operator to the given expression.
   * @param expression the expression computing the operand for the operator
   */
  void set operand3(Expression expression) {
    _operand = becomeParentOf(expression);
  }
  /**
   * Set the prefix operator being applied to the operand to the given operator.
   * @param operator the prefix operator being applied to the operand
   */
  void set operator5(Token operator) {
    this._operator = operator;
  }
  void visitChildren(ASTVisitor<Object> visitor) {
    safelyVisitChild(_operand, visitor);
  }
}
/**
 * Instances of the class {@code PrefixedIdentifier} represent either an identifier that is prefixed
 * or an access to an object property where the target of the property access is a simple
 * identifier.
 * <pre>
 * prefixedIdentifier ::={@link SimpleIdentifier prefix} '.' {@link SimpleIdentifier identifier}</pre>
 */
class PrefixedIdentifier extends Identifier {
  /**
   * The prefix associated with the library in which the identifier is defined.
   */
  SimpleIdentifier _prefix;
  /**
   * The period used to separate the prefix from the identifier.
   */
  Token _period;
  /**
   * The identifier being prefixed.
   */
  SimpleIdentifier _identifier;
  /**
   * Initialize a newly created prefixed identifier.
   * @param prefix the identifier being prefixed
   * @param period the period used to separate the prefix from the identifier
   * @param identifier the prefix associated with the library in which the identifier is defined
   */
  PrefixedIdentifier(SimpleIdentifier prefix, Token period, SimpleIdentifier identifier) {
    this._prefix = becomeParentOf(prefix);
    this._period = period;
    this._identifier = becomeParentOf(identifier);
  }
  accept(ASTVisitor visitor) => visitor.visitPrefixedIdentifier(this);
  Token get beginToken => _prefix.beginToken;
  Token get endToken => _identifier.endToken;
  /**
   * Return the identifier being prefixed.
   * @return the identifier being prefixed
   */
  SimpleIdentifier get identifier => _identifier;
  String get name => "${_prefix.name}.${_identifier.name}";
  /**
   * Return the period used to separate the prefix from the identifier.
   * @return the period used to separate the prefix from the identifier
   */
  Token get period => _period;
  /**
   * Return the prefix associated with the library in which the identifier is defined.
   * @return the prefix associated with the library in which the identifier is defined
   */
  SimpleIdentifier get prefix => _prefix;
  /**
   * Set the identifier being prefixed to the given identifier.
   * @param identifier the identifier being prefixed
   */
  void set identifier5(SimpleIdentifier identifier) {
    this._identifier = becomeParentOf(identifier);
  }
  /**
   * Set the period used to separate the prefix from the identifier to the given token.
   * @param period the period used to separate the prefix from the identifier
   */
  void set period9(Token period) {
    this._period = period;
  }
  /**
   * Set the prefix associated with the library in which the identifier is defined to the given
   * identifier.
   * @param identifier the prefix associated with the library in which the identifier is defined
   */
  void set prefix3(SimpleIdentifier identifier) {
    _prefix = becomeParentOf(identifier);
  }
  void visitChildren(ASTVisitor<Object> visitor) {
    safelyVisitChild(_prefix, visitor);
    safelyVisitChild(_identifier, visitor);
  }
}
/**
 * Instances of the class {@code PropertyAccess} represent the access of a property of an object.
 * <p>
 * Note, however, that accesses to properties of objects can also be represented as{@link PrefixedIdentifier prefixed identifier} nodes in cases where the target is also a simple
 * identifier.
 * <pre>
 * propertyAccess ::={@link Expression target} '.' {@link SimpleIdentifier propertyName}</pre>
 */
class PropertyAccess extends Expression {
  /**
   * The expression computing the object defining the property being accessed.
   */
  Expression _target;
  /**
   * The property access operator.
   */
  Token _operator;
  /**
   * The name of the property being accessed.
   */
  SimpleIdentifier _propertyName;
  /**
   * Initialize a newly created property access expression.
   * @param target the expression computing the object defining the property being accessed
   * @param operator the property access operator
   * @param propertyName the name of the property being accessed
   */
  PropertyAccess(Expression target, Token operator, SimpleIdentifier propertyName) {
    this._target = becomeParentOf(target);
    this._operator = operator;
    this._propertyName = becomeParentOf(propertyName);
  }
  accept(ASTVisitor visitor) => visitor.visitPropertyAccess(this);
  Token get beginToken {
    if (_target != null) {
      return _target.beginToken;
    }
    return _operator;
  }
  Token get endToken => _propertyName.endToken;
  /**
   * Return the property access operator.
   * @return the property access operator
   */
  Token get operator => _operator;
  /**
   * Return the name of the property being accessed.
   * @return the name of the property being accessed
   */
  SimpleIdentifier get propertyName => _propertyName;
  /**
   * Return the expression used to compute the receiver of the invocation. If this invocation is not
   * part of a cascade expression, then this is the same as {@link #getTarget()}. If this invocation
   * is part of a cascade expression, then the target stored with the cascade expression is
   * returned.
   * @return the expression used to compute the receiver of the invocation
   * @see #getTarget()
   */
  Expression get realTarget {
    if (isCascaded()) {
      ASTNode ancestor = parent;
      while (ancestor is! CascadeExpression) {
        if (ancestor == null) {
          return _target;
        }
        ancestor = ancestor.parent;
      }
      return (ancestor as CascadeExpression).target;
    }
    return _target;
  }
  /**
   * Return the expression computing the object defining the property being accessed, or{@code null} if this property access is part of a cascade expression.
   * @return the expression computing the object defining the property being accessed
   * @see #getRealTarget()
   */
  Expression get target => _target;
  bool isAssignable() => true;
  /**
   * Return {@code true} if this expression is cascaded. If it is, then the target of this
   * expression is not stored locally but is stored in the nearest ancestor that is a{@link CascadeExpression}.
   * @return {@code true} if this expression is cascaded
   */
  bool isCascaded() => _operator != null && _operator.type == TokenType.PERIOD_PERIOD;
  /**
   * Set the property access operator to the given token.
   * @param operator the property access operator
   */
  void set operator6(Token operator) {
    this._operator = operator;
  }
  /**
   * Set the name of the property being accessed to the given identifier.
   * @param identifier the name of the property being accessed
   */
  void set propertyName2(SimpleIdentifier identifier) {
    _propertyName = becomeParentOf(identifier);
  }
  /**
   * Set the expression computing the object defining the property being accessed to the given
   * expression.
   * @param expression the expression computing the object defining the property being accessed
   */
  void set target4(Expression expression) {
    _target = becomeParentOf(expression);
  }
  void visitChildren(ASTVisitor<Object> visitor) {
    safelyVisitChild(_target, visitor);
    safelyVisitChild(_propertyName, visitor);
  }
}
/**
 * Instances of the class {@code RedirectingConstructorInvocation} represent the invocation of a
 * another constructor in the same class from within a constructor's initialization list.
 * <pre>
 * redirectingConstructorInvocation ::=
 * 'this' ('.' identifier)? arguments
 * </pre>
 */
class RedirectingConstructorInvocation extends ConstructorInitializer {
  /**
   * The token for the 'this' keyword.
   */
  Token _keyword;
  /**
   * The token for the period before the name of the constructor that is being invoked, or{@code null} if the unnamed constructor is being invoked.
   */
  Token _period;
  /**
   * The name of the constructor that is being invoked, or {@code null} if the unnamed constructor
   * is being invoked.
   */
  SimpleIdentifier _constructorName;
  /**
   * The list of arguments to the constructor.
   */
  ArgumentList _argumentList;
  /**
   * Initialize a newly created redirecting invocation to invoke the constructor with the given name
   * with the given arguments.
   * @param keyword the token for the 'this' keyword
   * @param period the token for the period before the name of the constructor that is being invoked
   * @param constructorName the name of the constructor that is being invoked
   * @param argumentList the list of arguments to the constructor
   */
  RedirectingConstructorInvocation(Token keyword, Token period, SimpleIdentifier constructorName, ArgumentList argumentList) {
    this._keyword = keyword;
    this._period = period;
    this._constructorName = becomeParentOf(constructorName);
    this._argumentList = becomeParentOf(argumentList);
  }
  accept(ASTVisitor visitor) => visitor.visitRedirectingConstructorInvocation(this);
  /**
   * Return the list of arguments to the constructor.
   * @return the list of arguments to the constructor
   */
  ArgumentList get argumentList => _argumentList;
  Token get beginToken => _keyword;
  /**
   * Return the name of the constructor that is being invoked, or {@code null} if the unnamed
   * constructor is being invoked.
   * @return the name of the constructor that is being invoked
   */
  SimpleIdentifier get constructorName => _constructorName;
  Token get endToken => _argumentList.endToken;
  /**
   * Return the token for the 'this' keyword.
   * @return the token for the 'this' keyword
   */
  Token get keyword => _keyword;
  /**
   * Return the token for the period before the name of the constructor that is being invoked, or{@code null} if the unnamed constructor is being invoked.
   * @return the token for the period before the name of the constructor that is being invoked
   */
  Token get period => _period;
  /**
   * Set the list of arguments to the constructor to the given list.
   * @param argumentList the list of arguments to the constructor
   */
  void set argumentList8(ArgumentList argumentList) {
    this._argumentList = becomeParentOf(argumentList);
  }
  /**
   * Set the name of the constructor that is being invoked to the given identifier.
   * @param identifier the name of the constructor that is being invoked
   */
  void set constructorName4(SimpleIdentifier identifier) {
    _constructorName = becomeParentOf(identifier);
  }
  /**
   * Set the token for the 'this' keyword to the given token.
   * @param keyword the token for the 'this' keyword
   */
  void set keyword14(Token keyword) {
    this._keyword = keyword;
  }
  /**
   * Set the token for the period before the name of the constructor that is being invoked to the
   * given token.
   * @param period the token for the period before the name of the constructor that is being invoked
   */
  void set period10(Token period) {
    this._period = period;
  }
  void visitChildren(ASTVisitor<Object> visitor) {
    safelyVisitChild(_constructorName, visitor);
    safelyVisitChild(_argumentList, visitor);
  }
}
/**
 * Instances of the class {@code ReturnStatement} represent a return statement.
 * <pre>
 * returnStatement ::=
 * 'return' {@link Expression expression}? ';'
 * </pre>
 */
class ReturnStatement extends Statement {
  /**
   * The token representing the 'return' keyword.
   */
  Token _keyword;
  /**
   * The expression computing the value to be returned, or {@code null} if no explicit value was
   * provided.
   */
  Expression _expression;
  /**
   * The semicolon terminating the statement.
   */
  Token _semicolon;
  /**
   * Initialize a newly created return statement.
   * @param keyword the token representing the 'return' keyword
   * @param expression the expression computing the value to be returned
   * @param semicolon the semicolon terminating the statement
   */
  ReturnStatement(Token keyword, Expression expression, Token semicolon) {
    this._keyword = keyword;
    this._expression = becomeParentOf(expression);
    this._semicolon = semicolon;
  }
  accept(ASTVisitor visitor) => visitor.visitReturnStatement(this);
  Token get beginToken => _keyword;
  Token get endToken => _semicolon;
  /**
   * Return the expression computing the value to be returned, or {@code null} if no explicit value
   * was provided.
   * @return the expression computing the value to be returned
   */
  Expression get expression => _expression;
  /**
   * Return the token representing the 'return' keyword.
   * @return the token representing the 'return' keyword
   */
  Token get keyword => _keyword;
  /**
   * Return the semicolon terminating the statement.
   * @return the semicolon terminating the statement
   */
  Token get semicolon => _semicolon;
  /**
   * Set the expression computing the value to be returned to the given expression.
   * @param expression the expression computing the value to be returned
   */
  void set expression10(Expression expression) {
    this._expression = becomeParentOf(expression);
  }
  /**
   * Set the token representing the 'return' keyword to the given token.
   * @param keyword the token representing the 'return' keyword
   */
  void set keyword15(Token keyword) {
    this._keyword = keyword;
  }
  /**
   * Set the semicolon terminating the statement to the given token.
   * @param semicolon the semicolon terminating the statement
   */
  void set semicolon15(Token semicolon) {
    this._semicolon = semicolon;
  }
  void visitChildren(ASTVisitor<Object> visitor) {
    safelyVisitChild(_expression, visitor);
  }
}
/**
 * Instances of the class {@code ScriptTag} represent the script tag that can optionally occur at
 * the beginning of a compilation unit.
 * <pre>
 * scriptTag ::=
 * '#!' (~NEWLINE)* NEWLINE
 * </pre>
 */
class ScriptTag extends ASTNode {
  /**
   * The token representing this script tag.
   */
  Token _scriptTag;
  /**
   * Initialize a newly created script tag.
   * @param scriptTag the token representing this script tag
   */
  ScriptTag(Token scriptTag) {
    this._scriptTag = scriptTag;
  }
  accept(ASTVisitor visitor) => visitor.visitScriptTag(this);
  Token get beginToken => _scriptTag;
  Token get endToken => _scriptTag;
  /**
   * Return the token representing this script tag.
   * @return the token representing this script tag
   */
  Token get scriptTag => _scriptTag;
  /**
   * Set the token representing this script tag to the given script tag.
   * @param scriptTag the token representing this script tag
   */
  void set scriptTag3(Token scriptTag) {
    this._scriptTag = scriptTag;
  }
  void visitChildren(ASTVisitor<Object> visitor) {
  }
}
/**
 * Instances of the class {@code ShowCombinator} represent a combinator that restricts the names
 * being imported to those in a given list.
 * <pre>
 * showCombinator ::=
 * 'show' {@link SimpleIdentifier identifier} (',' {@link SimpleIdentifier identifier})
 * </pre>
 */
class ShowCombinator extends Combinator {
  /**
   * The list of names from the library that are made visible by this combinator.
   */
  NodeList<SimpleIdentifier> _shownNames;
  /**
   * Initialize a newly created import show combinator.
   * @param keyword the comma introducing the combinator
   * @param shownNames the list of names from the library that are made visible by this combinator
   */
  ShowCombinator(Token keyword, List<SimpleIdentifier> shownNames) : super(keyword) {
    this._shownNames = new NodeList<SimpleIdentifier>(this);
    this._shownNames.addAll(shownNames);
  }
  accept(ASTVisitor visitor) => visitor.visitShowCombinator(this);
  Token get endToken => _shownNames.endToken;
  /**
   * Return the list of names from the library that are made visible by this combinator.
   * @return the list of names from the library that are made visible by this combinator
   */
  NodeList<SimpleIdentifier> get shownNames => _shownNames;
  void visitChildren(ASTVisitor<Object> visitor) {
    _shownNames.accept(visitor);
  }
}
/**
 * Instances of the class {@code SimpleFormalParameter} represent a simple formal parameter.
 * <pre>
 * simpleFormalParameter ::=
 * ('final' {@link TypeName type} | 'var' | {@link TypeName type})? {@link SimpleIdentifier identifier}</pre>
 */
class SimpleFormalParameter extends NormalFormalParameter {
  /**
   * The token representing either the 'final', 'const' or 'var' keyword, or {@code null} if no
   * keyword was used.
   */
  Token _keyword;
  /**
   * The name of the declared type of the parameter, or {@code null} if the parameter does not have
   * a declared type.
   */
  TypeName _type;
  /**
   * Initialize a newly created formal parameter.
   * @param comment the documentation comment associated with this parameter
   * @param metadata the annotations associated with this parameter
   * @param keyword the token representing either the 'final', 'const' or 'var' keyword
   * @param type the name of the declared type of the parameter
   * @param identifier the name of the parameter being declared
   */
  SimpleFormalParameter(Comment comment, List<Annotation> metadata, Token keyword, TypeName type, SimpleIdentifier identifier) : super(comment, metadata, identifier) {
    this._keyword = keyword;
    this._type = becomeParentOf(type);
  }
  accept(ASTVisitor visitor) => visitor.visitSimpleFormalParameter(this);
  Token get beginToken {
    if (_keyword != null) {
      return _keyword;
    } else if (_type != null) {
      return _type.beginToken;
    }
    return identifier.beginToken;
  }
  Token get endToken => identifier.endToken;
  /**
   * Return the token representing either the 'final', 'const' or 'var' keyword.
   * @return the token representing either the 'final', 'const' or 'var' keyword
   */
  Token get keyword => _keyword;
  /**
   * Return the name of the declared type of the parameter, or {@code null} if the parameter does
   * not have a declared type.
   * @return the name of the declared type of the parameter
   */
  TypeName get type => _type;
  bool isConst() => (_keyword is KeywordToken) && (_keyword as KeywordToken).keyword == Keyword.CONST;
  bool isFinal() => (_keyword is KeywordToken) && (_keyword as KeywordToken).keyword == Keyword.FINAL;
  /**
   * Set the token representing either the 'final', 'const' or 'var' keyword to the given token.
   * @param keyword the token representing either the 'final', 'const' or 'var' keyword
   */
  void set keyword16(Token keyword) {
    this._keyword = keyword;
  }
  /**
   * Set the name of the declared type of the parameter to the given type name.
   * @param typeName the name of the declared type of the parameter
   */
  void set type6(TypeName typeName) {
    _type = becomeParentOf(typeName);
  }
  void visitChildren(ASTVisitor<Object> visitor) {
    super.visitChildren(visitor);
    safelyVisitChild(_type, visitor);
    safelyVisitChild(identifier, visitor);
  }
}
/**
 * Instances of the class {@code SimpleIdentifier} represent a simple identifier.
 * <pre>
 * simpleIdentifier ::=
 * initialCharacter internalCharacter
 * initialCharacter ::= '_' | '$' | letter
 * internalCharacter ::= '_' | '$' | letter | digit
 * </pre>
 */
class SimpleIdentifier extends Identifier {
  /**
   * The token representing the identifier.
   */
  Token _token;
  /**
   * Initialize a newly created identifier.
   * @param token the token representing the identifier
   */
  SimpleIdentifier(Token token) {
    this._token = token;
  }
  accept(ASTVisitor visitor) => visitor.visitSimpleIdentifier(this);
  Token get beginToken => _token;
  Token get endToken => _token;
  String get name => _token.lexeme;
  /**
   * Return the token representing the identifier.
   * @return the token representing the identifier
   */
  Token get token => _token;
  /**
   * Return {@code true} if this expression is computing a right-hand value.
   * <p>
   * Note that {@link #inGetterContext()} and {@link #inSetterContext()} are not opposites, nor are
   * they mutually exclusive. In other words, it is possible for both methods to return {@code true}when invoked on the same node.
   * @return {@code true} if this expression is in a context where a getter will be invoked
   */
  bool inGetterContext() {
    ASTNode parent7 = parent;
    ASTNode target = this;
    if (parent7 is PrefixedIdentifier) {
      PrefixedIdentifier prefixed = parent7 as PrefixedIdentifier;
      if (prefixed.identifier != this) {
        return false;
      }
      parent7 = prefixed.parent;
      target = prefixed;
    }
    if (parent7 is AssignmentExpression) {
      AssignmentExpression expr = parent7 as AssignmentExpression;
      if (expr.leftHandSide == target && expr.operator.type == TokenType.EQ) {
        return false;
      }
    }
    return true;
  }
  /**
   * Return {@code true} if this expression is computing a left-hand value.
   * <p>
   * Note that {@link #inGetterContext()} and {@link #inSetterContext()} are not opposites, nor are
   * they mutually exclusive. In other words, it is possible for both methods to return {@code true}when invoked on the same node.
   * @return {@code true} if this expression is in a context where a setter will be invoked
   */
  bool inSetterContext() {
    ASTNode parent8 = parent;
    ASTNode target = this;
    if (parent8 is PrefixedIdentifier) {
      PrefixedIdentifier prefixed = parent8 as PrefixedIdentifier;
      if (prefixed.identifier != this) {
        return false;
      }
      parent8 = prefixed.parent;
      target = prefixed;
    }
    if (parent8 is PrefixExpression) {
      return (parent8 as PrefixExpression).operator.type.isIncrementOperator();
    } else if (parent8 is PostfixExpression) {
      return true;
    } else if (parent8 is AssignmentExpression) {
      return (parent8 as AssignmentExpression).leftHandSide == target;
    }
    return false;
  }
  bool isSynthetic() => _token.isSynthetic();
  /**
   * Set the token representing the identifier to the given token.
   * @param token the token representing the literal
   */
  void set token12(Token token) {
    this._token = token;
  }
  void visitChildren(ASTVisitor<Object> visitor) {
  }
}
/**
 * Instances of the class {@code SimpleStringLiteral} represent a string literal expression that
 * does not contain any interpolations.
 * <pre>
 * simpleStringLiteral ::=
 * rawStringLiteral
 * | basicStringLiteral
 * rawStringLiteral ::=
 * '@' basicStringLiteral
 * simpleStringLiteral ::=
 * multiLineStringLiteral
 * | singleLineStringLiteral
 * multiLineStringLiteral ::=
 * "'''" characters "'''"
 * | '"""' characters '"""'
 * singleLineStringLiteral ::=
 * "'" characters "'"
 * '"' characters '"'
 * </pre>
 */
class SimpleStringLiteral extends StringLiteral {
  /**
   * The token representing the literal.
   */
  Token _literal;
  /**
   * The value of the literal.
   */
  String _value;
  /**
   * Initialize a newly created simple string literal.
   * @param literal the token representing the literal
   * @param value the value of the literal
   */
  SimpleStringLiteral(Token literal, String value) {
    this._literal = literal;
    this._value = value;
  }
  accept(ASTVisitor visitor) => visitor.visitSimpleStringLiteral(this);
  Token get beginToken => _literal;
  Token get endToken => _literal;
  /**
   * Return the token representing the literal.
   * @return the token representing the literal
   */
  Token get literal => _literal;
  /**
   * Return the value of the literal.
   * @return the value of the literal
   */
  String get value => _value;
  /**
   * Return {@code true} if this string literal is a multi-line string.
   * @return {@code true} if this string literal is a multi-line string
   */
  bool isMultiline() {
    if (_value.length < 6) {
      return false;
    }
    return _value.endsWith("\"\"\"") || _value.endsWith("'''");
  }
  /**
   * Return {@code true} if this string literal is a raw string.
   * @return {@code true} if this string literal is a raw string
   */
  bool isRaw() => _value.charCodeAt(0) == 0x40;
  bool isSynthetic() => _literal.isSynthetic();
  /**
   * Set the token representing the literal to the given token.
   * @param literal the token representing the literal
   */
  void set literal6(Token literal) {
    this._literal = literal;
  }
  /**
   * Set the value of the literal to the given string.
   * @param string the value of the literal
   */
  void set value9(String string) {
    _value = string;
  }
  void visitChildren(ASTVisitor<Object> visitor) {
  }
}
/**
 * Instances of the class {@code Statement} defines the behavior common to nodes that represent a
 * statement.
 * <pre>
 * statement ::={@link Block block}| {@link VariableDeclarationStatement initializedVariableDeclaration ';'}| {@link ForStatement forStatement}| {@link ForEachStatement forEachStatement}| {@link WhileStatement whileStatement}| {@link DoStatement doStatement}| {@link SwitchStatement switchStatement}| {@link IfStatement ifStatement}| {@link TryStatement tryStatement}| {@link BreakStatement breakStatement}| {@link ContinueStatement continueStatement}| {@link ReturnStatement returnStatement}| {@link ExpressionStatement expressionStatement}| {@link FunctionDeclarationStatement functionSignature functionBody}</pre>
 */
abstract class Statement extends ASTNode {
}
/**
 * Instances of the class {@code StringInterpolation} represent a string interpolation literal.
 * <pre>
 * stringInterpolation ::=
 * ''' {@link InterpolationElement interpolationElement}* '''
 * | '"' {@link InterpolationElement interpolationElement}* '"'
 * </pre>
 */
class StringInterpolation extends StringLiteral {
  /**
   * The elements that will be composed to produce the resulting string.
   */
  NodeList<InterpolationElement> _elements;
  /**
   * Initialize a newly created string interpolation expression.
   * @param elements the elements that will be composed to produce the resulting string
   */
  StringInterpolation(List<InterpolationElement> elements) {
    this._elements = new NodeList<InterpolationElement>(this);
    this._elements.addAll(elements);
  }
  accept(ASTVisitor visitor) => visitor.visitStringInterpolation(this);
  Token get beginToken => _elements.beginToken;
  /**
   * Return the elements that will be composed to produce the resulting string.
   * @return the elements that will be composed to produce the resulting string
   */
  NodeList<InterpolationElement> get elements => _elements;
  Token get endToken => _elements.endToken;
  void visitChildren(ASTVisitor<Object> visitor) {
    _elements.accept(visitor);
  }
}
/**
 * Instances of the class {@code StringLiteral} represent a string literal expression.
 * <pre>
 * stringLiteral ::={@link SimpleStringLiteral simpleStringLiteral}| {@link AdjacentStrings adjacentStrings}| {@link StringInterpolation stringInterpolation}</pre>
 */
abstract class StringLiteral extends Literal {
}
/**
 * Instances of the class {@code SuperConstructorInvocation} represent the invocation of a
 * superclass' constructor from within a constructor's initialization list.
 * <pre>
 * superInvocation ::=
 * 'super' ('.' {@link SimpleIdentifier name})? {@link ArgumentList argumentList}</pre>
 */
class SuperConstructorInvocation extends ConstructorInitializer {
  /**
   * The token for the 'super' keyword.
   */
  Token _keyword;
  /**
   * The token for the period before the name of the constructor that is being invoked, or{@code null} if the unnamed constructor is being invoked.
   */
  Token _period;
  /**
   * The name of the constructor that is being invoked, or {@code null} if the unnamed constructor
   * is being invoked.
   */
  SimpleIdentifier _constructorName;
  /**
   * The list of arguments to the constructor.
   */
  ArgumentList _argumentList;
  /**
   * Initialize a newly created super invocation to invoke the inherited constructor with the given
   * name with the given arguments.
   * @param keyword the token for the 'super' keyword
   * @param period the token for the period before the name of the constructor that is being invoked
   * @param constructorName the name of the constructor that is being invoked
   * @param argumentList the list of arguments to the constructor
   */
  SuperConstructorInvocation(Token keyword, Token period, SimpleIdentifier constructorName, ArgumentList argumentList) {
    this._keyword = keyword;
    this._period = period;
    this._constructorName = becomeParentOf(constructorName);
    this._argumentList = becomeParentOf(argumentList);
  }
  accept(ASTVisitor visitor) => visitor.visitSuperConstructorInvocation(this);
  /**
   * Return the list of arguments to the constructor.
   * @return the list of arguments to the constructor
   */
  ArgumentList get argumentList => _argumentList;
  Token get beginToken => _keyword;
  /**
   * Return the name of the constructor that is being invoked, or {@code null} if the unnamed
   * constructor is being invoked.
   * @return the name of the constructor that is being invoked
   */
  SimpleIdentifier get constructorName => _constructorName;
  Token get endToken => _argumentList.endToken;
  /**
   * Return the token for the 'super' keyword.
   * @return the token for the 'super' keyword
   */
  Token get keyword => _keyword;
  /**
   * Return the token for the period before the name of the constructor that is being invoked, or{@code null} if the unnamed constructor is being invoked.
   * @return the token for the period before the name of the constructor that is being invoked
   */
  Token get period => _period;
  /**
   * Set the list of arguments to the constructor to the given list.
   * @param argumentList the list of arguments to the constructor
   */
  void set argumentList9(ArgumentList argumentList) {
    this._argumentList = becomeParentOf(argumentList);
  }
  /**
   * Set the name of the constructor that is being invoked to the given identifier.
   * @param identifier the name of the constructor that is being invoked
   */
  void set constructorName5(SimpleIdentifier identifier) {
    _constructorName = becomeParentOf(identifier);
  }
  /**
   * Set the token for the 'super' keyword to the given token.
   * @param keyword the token for the 'super' keyword
   */
  void set keyword17(Token keyword) {
    this._keyword = keyword;
  }
  /**
   * Set the token for the period before the name of the constructor that is being invoked to the
   * given token.
   * @param period the token for the period before the name of the constructor that is being invoked
   */
  void set period11(Token period) {
    this._period = period;
  }
  void visitChildren(ASTVisitor<Object> visitor) {
    safelyVisitChild(_constructorName, visitor);
    safelyVisitChild(_argumentList, visitor);
  }
}
/**
 * Instances of the class {@code SuperExpression} represent a super expression.
 * <pre>
 * superExpression ::=
 * 'super'
 * </pre>
 */
class SuperExpression extends Expression {
  /**
   * The token representing the keyword.
   */
  Token _keyword;
  /**
   * Initialize a newly created super expression.
   * @param keyword the token representing the keyword
   */
  SuperExpression(Token keyword) {
    this._keyword = keyword;
  }
  accept(ASTVisitor visitor) => visitor.visitSuperExpression(this);
  Token get beginToken => _keyword;
  Token get endToken => _keyword;
  /**
   * Return the token representing the keyword.
   * @return the token representing the keyword
   */
  Token get keyword => _keyword;
  /**
   * Set the token representing the keyword to the given token.
   * @param keyword the token representing the keyword
   */
  void set keyword18(Token keyword) {
    this._keyword = keyword;
  }
  void visitChildren(ASTVisitor<Object> visitor) {
  }
}
/**
 * Instances of the class {@code SwitchCase} represent the case in a switch statement.
 * <pre>
 * switchCase ::={@link SimpleIdentifier label}* 'case' {@link Expression expression} ':' {@link Statement statement}</pre>
 */
class SwitchCase extends SwitchMember {
  /**
   * The expression controlling whether the statements will be executed.
   */
  Expression _expression;
  /**
   * Initialize a newly created switch case.
   * @param labels the labels associated with the switch member
   * @param keyword the token representing the 'case' or 'default' keyword
   * @param expression the expression controlling whether the statements will be executed
   * @param colon the colon separating the keyword or the expression from the statements
   * @param statements the statements that will be executed if this switch member is selected
   */
  SwitchCase(List<Label> labels, Token keyword, Expression expression, Token colon, List<Statement> statements) : super(labels, keyword, colon, statements) {
    this._expression = becomeParentOf(expression);
  }
  accept(ASTVisitor visitor) => visitor.visitSwitchCase(this);
  /**
   * Return the expression controlling whether the statements will be executed.
   * @return the expression controlling whether the statements will be executed
   */
  Expression get expression => _expression;
  /**
   * Set the expression controlling whether the statements will be executed to the given expression.
   * @param expression the expression controlling whether the statements will be executed
   */
  void set expression11(Expression expression) {
    this._expression = becomeParentOf(expression);
  }
  void visitChildren(ASTVisitor<Object> visitor) {
    labels.accept(visitor);
    safelyVisitChild(_expression, visitor);
    statements.accept(visitor);
  }
}
/**
 * Instances of the class {@code SwitchDefault} represent the default case in a switch statement.
 * <pre>
 * switchDefault ::={@link SimpleIdentifier label}* 'default' ':' {@link Statement statement}</pre>
 */
class SwitchDefault extends SwitchMember {
  /**
   * Initialize a newly created switch default.
   * @param labels the labels associated with the switch member
   * @param keyword the token representing the 'case' or 'default' keyword
   * @param colon the colon separating the keyword or the expression from the statements
   * @param statements the statements that will be executed if this switch member is selected
   */
  SwitchDefault(List<Label> labels, Token keyword, Token colon, List<Statement> statements) : super(labels, keyword, colon, statements) {
  }
  accept(ASTVisitor visitor) => visitor.visitSwitchDefault(this);
  void visitChildren(ASTVisitor<Object> visitor) {
    labels.accept(visitor);
    statements.accept(visitor);
  }
}
/**
 * The abstract class {@code SwitchMember} defines the behavior common to objects representing
 * elements within a switch statement.
 * <pre>
 * switchMember ::=
 * switchCase
 * | switchDefault
 * </pre>
 */
abstract class SwitchMember extends ASTNode {
  /**
   * The labels associated with the switch member.
   */
  NodeList<Label> _labels;
  /**
   * The token representing the 'case' or 'default' keyword.
   */
  Token _keyword;
  /**
   * The colon separating the keyword or the expression from the statements.
   */
  Token _colon;
  /**
   * The statements that will be executed if this switch member is selected.
   */
  NodeList<Statement> _statements;
  /**
   * Initialize a newly created switch member.
   * @param labels the labels associated with the switch member
   * @param keyword the token representing the 'case' or 'default' keyword
   * @param colon the colon separating the keyword or the expression from the statements
   * @param statements the statements that will be executed if this switch member is selected
   */
  SwitchMember(List<Label> labels, Token keyword, Token colon, List<Statement> statements) {
    this._labels = new NodeList<Label>(this);
    this._statements = new NodeList<Statement>(this);
    this._labels.addAll(labels);
    this._keyword = keyword;
    this._colon = colon;
    this._statements.addAll(statements);
  }
  Token get beginToken {
    if (!_labels.isEmpty) {
      return _labels.beginToken;
    }
    return _keyword;
  }
  /**
   * Return the colon separating the keyword or the expression from the statements.
   * @return the colon separating the keyword or the expression from the statements
   */
  Token get colon => _colon;
  Token get endToken {
    if (!_statements.isEmpty) {
      return _statements.endToken;
    }
    return _colon;
  }
  /**
   * Return the token representing the 'case' or 'default' keyword.
   * @return the token representing the 'case' or 'default' keyword
   */
  Token get keyword => _keyword;
  /**
   * Return the labels associated with the switch member.
   * @return the labels associated with the switch member
   */
  NodeList<Label> get labels => _labels;
  /**
   * Return the statements that will be executed if this switch member is selected.
   * @return the statements that will be executed if this switch member is selected
   */
  NodeList<Statement> get statements => _statements;
  /**
   * Set the colon separating the keyword or the expression from the statements to the given token.
   * @param colon the colon separating the keyword or the expression from the statements
   */
  void set colon4(Token colon) {
    this._colon = colon;
  }
  /**
   * Set the token representing the 'case' or 'default' keyword to the given token.
   * @param keyword the token representing the 'case' or 'default' keyword
   */
  void set keyword19(Token keyword) {
    this._keyword = keyword;
  }
}
/**
 * Instances of the class {@code SwitchStatement} represent a switch statement.
 * <pre>
 * switchStatement ::=
 * 'switch' '(' {@link Expression expression} ')' '{' {@link SwitchCase switchCase}* {@link SwitchDefault defaultCase}? '}'
 * </pre>
 */
class SwitchStatement extends Statement {
  /**
   * The token representing the 'switch' keyword.
   */
  Token _keyword;
  /**
   * The left parenthesis.
   */
  Token _leftParenthesis;
  /**
   * The expression used to determine which of the switch members will be selected.
   */
  Expression _expression;
  /**
   * The right parenthesis.
   */
  Token _rightParenthesis;
  /**
   * The left curly bracket.
   */
  Token _leftBracket;
  /**
   * The switch members that can be selected by the expression.
   */
  NodeList<SwitchMember> _members;
  /**
   * The right curly bracket.
   */
  Token _rightBracket;
  /**
   * Initialize a newly created switch statement.
   * @param keyword the token representing the 'switch' keyword
   * @param leftParenthesis the left parenthesis
   * @param expression the expression used to determine which of the switch members will be selected
   * @param rightParenthesis the right parenthesis
   * @param leftBracket the left curly bracket
   * @param members the switch members that can be selected by the expression
   * @param rightBracket the right curly bracket
   */
  SwitchStatement(Token keyword, Token leftParenthesis, Expression expression, Token rightParenthesis, Token leftBracket, List<SwitchMember> members, Token rightBracket) {
    this._members = new NodeList<SwitchMember>(this);
    this._keyword = keyword;
    this._leftParenthesis = leftParenthesis;
    this._expression = becomeParentOf(expression);
    this._rightParenthesis = rightParenthesis;
    this._leftBracket = leftBracket;
    this._members.addAll(members);
    this._rightBracket = rightBracket;
  }
  accept(ASTVisitor visitor) => visitor.visitSwitchStatement(this);
  Token get beginToken => _keyword;
  Token get endToken => _rightBracket;
  /**
   * Return the expression used to determine which of the switch members will be selected.
   * @return the expression used to determine which of the switch members will be selected
   */
  Expression get expression => _expression;
  /**
   * Return the token representing the 'switch' keyword.
   * @return the token representing the 'switch' keyword
   */
  Token get keyword => _keyword;
  /**
   * Return the left curly bracket.
   * @return the left curly bracket
   */
  Token get leftBracket => _leftBracket;
  /**
   * Return the left parenthesis.
   * @return the left parenthesis
   */
  Token get leftParenthesis => _leftParenthesis;
  /**
   * Return the switch members that can be selected by the expression.
   * @return the switch members that can be selected by the expression
   */
  NodeList<SwitchMember> get members => _members;
  /**
   * Return the right curly bracket.
   * @return the right curly bracket
   */
  Token get rightBracket => _rightBracket;
  /**
   * Return the right parenthesis.
   * @return the right parenthesis
   */
  Token get rightParenthesis => _rightParenthesis;
  /**
   * Set the expression used to determine which of the switch members will be selected to the given
   * expression.
   * @param expression the expression used to determine which of the switch members will be selected
   */
  void set expression12(Expression expression) {
    this._expression = becomeParentOf(expression);
  }
  /**
   * Set the token representing the 'switch' keyword to the given token.
   * @param keyword the token representing the 'switch' keyword
   */
  void set keyword20(Token keyword) {
    this._keyword = keyword;
  }
  /**
   * Set the left curly bracket to the given token.
   * @param leftBracket the left curly bracket
   */
  void set leftBracket8(Token leftBracket) {
    this._leftBracket = leftBracket;
  }
  /**
   * Set the left parenthesis to the given token.
   * @param leftParenthesis the left parenthesis
   */
  void set leftParenthesis11(Token leftParenthesis) {
    this._leftParenthesis = leftParenthesis;
  }
  /**
   * Set the right curly bracket to the given token.
   * @param rightBracket the right curly bracket
   */
  void set rightBracket8(Token rightBracket) {
    this._rightBracket = rightBracket;
  }
  /**
   * Set the right parenthesis to the given token.
   * @param rightParenthesis the right parenthesis
   */
  void set rightParenthesis11(Token rightParenthesis) {
    this._rightParenthesis = rightParenthesis;
  }
  void visitChildren(ASTVisitor<Object> visitor) {
    safelyVisitChild(_expression, visitor);
    _members.accept(visitor);
  }
}
/**
 * Instances of the class {@code ThisExpression} represent a this expression.
 * <pre>
 * thisExpression ::=
 * 'this'
 * </pre>
 */
class ThisExpression extends Expression {
  /**
   * The token representing the keyword.
   */
  Token _keyword;
  /**
   * Initialize a newly created this expression.
   * @param keyword the token representing the keyword
   */
  ThisExpression(Token keyword) {
    this._keyword = keyword;
  }
  accept(ASTVisitor visitor) => visitor.visitThisExpression(this);
  Token get beginToken => _keyword;
  Token get endToken => _keyword;
  /**
   * Return the token representing the keyword.
   * @return the token representing the keyword
   */
  Token get keyword => _keyword;
  /**
   * Set the token representing the keyword to the given token.
   * @param keyword the token representing the keyword
   */
  void set keyword21(Token keyword) {
    this._keyword = keyword;
  }
  void visitChildren(ASTVisitor<Object> visitor) {
  }
}
/**
 * Instances of the class {@code ThrowExpression} represent a throw expression.
 * <pre>
 * throwExpression ::=
 * 'throw' {@link Expression expression}? ';'
 * </pre>
 */
class ThrowExpression extends Expression {
  /**
   * The token representing the 'throw' keyword.
   */
  Token _keyword;
  /**
   * The expression computing the exception to be thrown, or {@code null} if the current exception
   * is to be re-thrown. (The latter case can only occur if the throw statement is inside a catch
   * clause.)
   */
  Expression _expression;
  /**
   * Initialize a newly created throw expression.
   * @param keyword the token representing the 'throw' keyword
   * @param expression the expression computing the exception to be thrown
   */
  ThrowExpression(Token keyword, Expression expression) {
    this._keyword = keyword;
    this._expression = becomeParentOf(expression);
  }
  accept(ASTVisitor visitor) => visitor.visitThrowExpression(this);
  Token get beginToken => _keyword;
  Token get endToken {
    if (_expression != null) {
      return _expression.endToken;
    }
    return _keyword;
  }
  /**
   * Return the expression computing the exception to be thrown, or {@code null} if the current
   * exception is to be re-thrown. (The latter case can only occur if the throw statement is inside
   * a catch clause.)
   * @return the expression computing the exception to be thrown
   */
  Expression get expression => _expression;
  /**
   * Return the token representing the 'throw' keyword.
   * @return the token representing the 'throw' keyword
   */
  Token get keyword => _keyword;
  /**
   * Set the expression computing the exception to be thrown to the given expression.
   * @param expression the expression computing the exception to be thrown
   */
  void set expression13(Expression expression) {
    this._expression = becomeParentOf(expression);
  }
  /**
   * Set the token representing the 'throw' keyword to the given token.
   * @param keyword the token representing the 'throw' keyword
   */
  void set keyword22(Token keyword) {
    this._keyword = keyword;
  }
  void visitChildren(ASTVisitor<Object> visitor) {
    safelyVisitChild(_expression, visitor);
  }
}
/**
 * Instances of the class {@code TopLevelVariableDeclaration} represent the declaration of one or
 * more top-level variables of the same type.
 * <pre>
 * topLevelVariableDeclaration ::=
 * ('final' | 'const') type? staticFinalDeclarationList ';'
 * | variableDeclaration ';'
 * </pre>
 */
class TopLevelVariableDeclaration extends CompilationUnitMember {
  /**
   * The top-level variables being declared.
   */
  VariableDeclarationList _variableList;
  /**
   * The semicolon terminating the declaration.
   */
  Token _semicolon;
  /**
   * Initialize a newly created top-level variable declaration.
   * @param comment the documentation comment associated with this variable
   * @param metadata the annotations associated with this variable
   * @param variableList the top-level variables being declared
   * @param semicolon the semicolon terminating the declaration
   */
  TopLevelVariableDeclaration(Comment comment, List<Annotation> metadata, VariableDeclarationList variableList, Token semicolon) : super(comment, metadata) {
    this._variableList = becomeParentOf(variableList);
    this._semicolon = semicolon;
  }
  accept(ASTVisitor visitor) => visitor.visitTopLevelVariableDeclaration(this);
  Token get endToken => _semicolon;
  /**
   * Return the semicolon terminating the declaration.
   * @return the semicolon terminating the declaration
   */
  Token get semicolon => _semicolon;
  /**
   * Return the top-level variables being declared.
   * @return the top-level variables being declared
   */
  VariableDeclarationList get variables => _variableList;
  /**
   * Set the semicolon terminating the declaration to the given token.
   * @param semicolon the semicolon terminating the declaration
   */
  void set semicolon16(Token semicolon) {
    this._semicolon = semicolon;
  }
  /**
   * Set the top-level variables being declared to the given list of variables.
   * @param variableList the top-level variables being declared
   */
  void set variables3(VariableDeclarationList variableList) {
    variableList = becomeParentOf(variableList);
  }
  void visitChildren(ASTVisitor<Object> visitor) {
    super.visitChildren(visitor);
    safelyVisitChild(_variableList, visitor);
  }
  Token get firstTokenAfterCommentAndMetadata => _variableList.beginToken;
}
/**
 * Instances of the class {@code TryStatement} represent a try statement.
 * <pre>
 * tryStatement ::=
 * 'try' {@link Block block} ({@link CatchClause catchClause}+ finallyClause? | finallyClause)
 * finallyClause ::=
 * 'finally' {@link Block block}</pre>
 */
class TryStatement extends Statement {
  /**
   * The token representing the 'try' keyword.
   */
  Token _tryKeyword;
  /**
   * The body of the statement.
   */
  Block _body;
  /**
   * The catch clauses contained in the try statement.
   */
  NodeList<CatchClause> _catchClauses;
  /**
   * The token representing the 'finally' keyword, or {@code null} if the statement does not contain
   * a finally clause.
   */
  Token _finallyKeyword;
  /**
   * The finally clause contained in the try statement, or {@code null} if the statement does not
   * contain a finally clause.
   */
  Block _finallyClause;
  /**
   * Initialize a newly created try statement.
   * @param tryKeyword the token representing the 'try' keyword
   * @param body the body of the statement
   * @param catchClauses the catch clauses contained in the try statement
   * @param finallyKeyword the token representing the 'finally' keyword
   * @param finallyClause the finally clause contained in the try statement
   */
  TryStatement(Token tryKeyword, Block body, List<CatchClause> catchClauses, Token finallyKeyword, Block finallyClause) {
    this._catchClauses = new NodeList<CatchClause>(this);
    this._tryKeyword = tryKeyword;
    this._body = becomeParentOf(body);
    this._catchClauses.addAll(catchClauses);
    this._finallyKeyword = finallyKeyword;
    this._finallyClause = becomeParentOf(finallyClause);
  }
  accept(ASTVisitor visitor) => visitor.visitTryStatement(this);
  Token get beginToken => _tryKeyword;
  /**
   * Return the body of the statement.
   * @return the body of the statement
   */
  Block get body => _body;
  /**
   * Return the catch clauses contained in the try statement.
   * @return the catch clauses contained in the try statement
   */
  NodeList<CatchClause> get catchClauses => _catchClauses;
  Token get endToken {
    if (_finallyClause != null) {
      return _finallyClause.endToken;
    } else if (_finallyKeyword != null) {
      return _finallyKeyword;
    } else if (!_catchClauses.isEmpty) {
      return _catchClauses.endToken;
    }
    return _body.endToken;
  }
  /**
   * Return the finally clause contained in the try statement, or {@code null} if the statement does
   * not contain a finally clause.
   * @return the finally clause contained in the try statement
   */
  Block get finallyClause => _finallyClause;
  /**
   * Return the token representing the 'finally' keyword, or {@code null} if the statement does not
   * contain a finally clause.
   * @return the token representing the 'finally' keyword
   */
  Token get finallyKeyword => _finallyKeyword;
  /**
   * Return the token representing the 'try' keyword.
   * @return the token representing the 'try' keyword
   */
  Token get tryKeyword => _tryKeyword;
  /**
   * Set the body of the statement to the given block.
   * @param block the body of the statement
   */
  void set body9(Block block) {
    _body = becomeParentOf(block);
  }
  /**
   * Set the finally clause contained in the try statement to the given block.
   * @param block the finally clause contained in the try statement
   */
  void set finallyClause2(Block block) {
    _finallyClause = becomeParentOf(block);
  }
  /**
   * Set the token representing the 'finally' keyword to the given token.
   * @param finallyKeyword the token representing the 'finally' keyword
   */
  void set finallyKeyword2(Token finallyKeyword) {
    this._finallyKeyword = finallyKeyword;
  }
  /**
   * Set the token representing the 'try' keyword to the given token.
   * @param tryKeyword the token representing the 'try' keyword
   */
  void set tryKeyword2(Token tryKeyword) {
    this._tryKeyword = tryKeyword;
  }
  void visitChildren(ASTVisitor<Object> visitor) {
    safelyVisitChild(_body, visitor);
    _catchClauses.accept(visitor);
    safelyVisitChild(_finallyClause, visitor);
  }
}
/**
 * The abstract class {@code TypeAlias} defines the behavior common to declarations of type aliases.
 * <pre>
 * typeAlias ::=
 * 'typedef' typeAliasBody
 * typeAliasBody ::=
 * classTypeAlias
 * | functionTypeAlias
 * </pre>
 */
abstract class TypeAlias extends CompilationUnitMember {
  /**
   * The token representing the 'typedef' keyword.
   */
  Token _keyword;
  /**
   * The semicolon terminating the declaration.
   */
  Token _semicolon;
  /**
   * Initialize a newly created type alias.
   * @param comment the documentation comment associated with this type alias
   * @param metadata the annotations associated with this type alias
   * @param keyword the token representing the 'typedef' keyword
   * @param semicolon the semicolon terminating the declaration
   */
  TypeAlias(Comment comment, List<Annotation> metadata, Token keyword, Token semicolon) : super(comment, metadata) {
    this._keyword = keyword;
    this._semicolon = semicolon;
  }
  Token get endToken => _semicolon;
  /**
   * Return the token representing the 'typedef' keyword.
   * @return the token representing the 'typedef' keyword
   */
  Token get keyword => _keyword;
  /**
   * Return the semicolon terminating the declaration.
   * @return the semicolon terminating the declaration
   */
  Token get semicolon => _semicolon;
  /**
   * Set the token representing the 'typedef' keyword to the given token.
   * @param keyword the token representing the 'typedef' keyword
   */
  void set keyword23(Token keyword) {
    this._keyword = keyword;
  }
  /**
   * Set the semicolon terminating the declaration to the given token.
   * @param semicolon the semicolon terminating the declaration
   */
  void set semicolon17(Token semicolon) {
    this._semicolon = semicolon;
  }
  Token get firstTokenAfterCommentAndMetadata => _keyword;
}
/**
 * Instances of the class {@code TypeArgumentList} represent a list of type arguments.
 * <pre>
 * typeArguments ::=
 * '<' typeName (',' typeName)* '>'
 * </pre>
 */
class TypeArgumentList extends ASTNode {
  /**
   * The left bracket.
   */
  Token _leftBracket;
  /**
   * The type arguments associated with the type.
   */
  NodeList<TypeName> _arguments;
  /**
   * The right bracket.
   */
  Token _rightBracket;
  /**
   * Initialize a newly created list of type arguments.
   * @param leftBracket the left bracket
   * @param arguments the type arguments associated with the type
   * @param rightBracket the right bracket
   */
  TypeArgumentList(Token leftBracket, List<TypeName> arguments, Token rightBracket) {
    this._arguments = new NodeList<TypeName>(this);
    this._leftBracket = leftBracket;
    this._arguments.addAll(arguments);
    this._rightBracket = rightBracket;
  }
  accept(ASTVisitor visitor) => visitor.visitTypeArgumentList(this);
  /**
   * Return the type arguments associated with the type.
   * @return the type arguments associated with the type
   */
  NodeList<TypeName> get arguments => _arguments;
  Token get beginToken => _leftBracket;
  Token get endToken => _rightBracket;
  /**
   * Return the left bracket.
   * @return the left bracket
   */
  Token get leftBracket => _leftBracket;
  /**
   * Return the right bracket.
   * @return the right bracket
   */
  Token get rightBracket => _rightBracket;
  /**
   * Set the left bracket to the given token.
   * @param leftBracket the left bracket
   */
  void set leftBracket9(Token leftBracket) {
    this._leftBracket = leftBracket;
  }
  /**
   * Set the right bracket to the given token.
   * @param rightBracket the right bracket
   */
  void set rightBracket9(Token rightBracket) {
    this._rightBracket = rightBracket;
  }
  void visitChildren(ASTVisitor<Object> visitor) {
    _arguments.accept(visitor);
  }
}
/**
 * Instances of the class {@code TypeName} represent the name of a type, which can optionally
 * include type arguments.
 * <pre>
 * typeName ::={@link Identifier identifier} typeArguments?
 * </pre>
 */
class TypeName extends ASTNode {
  /**
   * The name of the type.
   */
  Identifier _name;
  /**
   * The type arguments associated with the type, or {@code null} if there are no type arguments.
   */
  TypeArgumentList _typeArguments;
  /**
   * The type being named, or {@code null} if the AST structure has not been resolved.
   */
  Type2 _type;
  /**
   * Initialize a newly created type name.
   * @param name the name of the type
   * @param typeArguments the type arguments associated with the type, or {@code null} if there are
   * no type arguments
   */
  TypeName(Identifier name, TypeArgumentList typeArguments) {
    this._name = becomeParentOf(name);
    this._typeArguments = becomeParentOf(typeArguments);
  }
  accept(ASTVisitor visitor) => visitor.visitTypeName(this);
  Token get beginToken => _name.beginToken;
  Token get endToken {
    if (_typeArguments != null) {
      return _typeArguments.endToken;
    }
    return _name.endToken;
  }
  /**
   * Return the name of the type.
   * @return the name of the type
   */
  Identifier get name => _name;
  /**
   * Return the type being named, or {@code null} if the AST structure has not been resolved.
   * @return the type being named
   */
  Type2 get type => _type;
  /**
   * Return the type arguments associated with the type, or {@code null} if there are no type
   * arguments.
   * @return the type arguments associated with the type
   */
  TypeArgumentList get typeArguments => _typeArguments;
  bool isSynthetic() => _name.isSynthetic() && _typeArguments == null;
  /**
   * Set the name of the type to the given identifier.
   * @param identifier the name of the type
   */
  void set name12(Identifier identifier) {
    _name = becomeParentOf(identifier);
  }
  /**
   * Set the type being named to the given type.
   * @param type the type being named
   */
  void set type7(Type2 type) {
    this._type = type;
  }
  /**
   * Set the type arguments associated with the type to the given type arguments.
   * @param typeArguments the type arguments associated with the type
   */
  void set typeArguments2(TypeArgumentList typeArguments) {
    this._typeArguments = becomeParentOf(typeArguments);
  }
  void visitChildren(ASTVisitor<Object> visitor) {
    safelyVisitChild(_name, visitor);
    safelyVisitChild(_typeArguments, visitor);
  }
}
/**
 * Instances of the class {@code TypeParameter} represent a type parameter.
 * <pre>
 * typeParameter ::={@link SimpleIdentifier name} ('extends' {@link TypeName bound})?
 * </pre>
 */
class TypeParameter extends Declaration {
  /**
   * The name of the type parameter.
   */
  SimpleIdentifier _name;
  /**
   * The token representing the 'extends' keyword, or {@code null} if there was no explicit upper
   * bound.
   */
  Token _keyword;
  /**
   * The name of the upper bound for legal arguments, or {@code null} if there was no explicit upper
   * bound.
   */
  TypeName _bound;
  /**
   * Initialize a newly created type parameter.
   * @param comment the documentation comment associated with the type parameter
   * @param metadata the annotations associated with the type parameter
   * @param name the name of the type parameter
   * @param keyword the token representing the 'extends' keyword
   * @param bound the name of the upper bound for legal arguments
   */
  TypeParameter(Comment comment, List<Annotation> metadata, SimpleIdentifier name, Token keyword, TypeName bound) : super(comment, metadata) {
    this._name = becomeParentOf(name);
    this._keyword = keyword;
    this._bound = becomeParentOf(bound);
  }
  accept(ASTVisitor visitor) => visitor.visitTypeParameter(this);
  /**
   * Return the name of the upper bound for legal arguments, or {@code null} if there was no
   * explicit upper bound.
   * @return the name of the upper bound for legal arguments
   */
  TypeName get bound => _bound;
  Token get endToken {
    if (_bound == null) {
      return _name.endToken;
    }
    return _bound.endToken;
  }
  /**
   * Return the token representing the 'assert' keyword.
   * @return the token representing the 'assert' keyword
   */
  Token get keyword => _keyword;
  /**
   * Return the name of the type parameter.
   * @return the name of the type parameter
   */
  SimpleIdentifier get name => _name;
  /**
   * Set the name of the upper bound for legal arguments to the given type name.
   * @param typeName the name of the upper bound for legal arguments
   */
  void set bound2(TypeName typeName) {
    _bound = becomeParentOf(typeName);
  }
  /**
   * Set the token representing the 'assert' keyword to the given token.
   * @param keyword the token representing the 'assert' keyword
   */
  void set keyword24(Token keyword) {
    this._keyword = keyword;
  }
  /**
   * Set the name of the type parameter to the given identifier.
   * @param identifier the name of the type parameter
   */
  void set name13(SimpleIdentifier identifier) {
    _name = becomeParentOf(identifier);
  }
  void visitChildren(ASTVisitor<Object> visitor) {
    super.visitChildren(visitor);
    safelyVisitChild(_name, visitor);
    safelyVisitChild(_bound, visitor);
  }
  Token get firstTokenAfterCommentAndMetadata => _name.beginToken;
}
/**
 * Instances of the class {@code TypeParameterList} represent type parameters within a declaration.
 * <pre>
 * typeParameterList ::=
 * '<' {@link TypeParameter typeParameter} (',' {@link TypeParameter typeParameter})* '>'
 * </pre>
 */
class TypeParameterList extends ASTNode {
  /**
   * The left angle bracket.
   */
  Token _leftBracket;
  /**
   * The type parameters in the list.
   */
  NodeList<TypeParameter> _typeParameters;
  /**
   * The right angle bracket.
   */
  Token _rightBracket;
  /**
   * Initialize a newly created list of type parameters.
   * @param leftBracket the left angle bracket
   * @param typeParameters the type parameters in the list
   * @param rightBracket the right angle bracket
   */
  TypeParameterList(Token leftBracket, List<TypeParameter> typeParameters, Token rightBracket) {
    this._typeParameters = new NodeList<TypeParameter>(this);
    this._leftBracket = leftBracket;
    this._typeParameters.addAll(typeParameters);
    this._rightBracket = rightBracket;
  }
  accept(ASTVisitor visitor) => visitor.visitTypeParameterList(this);
  Token get beginToken => _leftBracket;
  Token get endToken => _rightBracket;
  /**
   * Return the left angle bracket.
   * @return the left angle bracket
   */
  Token get leftBracket => _leftBracket;
  /**
   * Return the right angle bracket.
   * @return the right angle bracket
   */
  Token get rightBracket => _rightBracket;
  /**
   * Return the type parameters for the type.
   * @return the type parameters for the type
   */
  NodeList<TypeParameter> get typeParameters => _typeParameters;
  void visitChildren(ASTVisitor<Object> visitor) {
    _typeParameters.accept(visitor);
  }
}
/**
 * The abstract class {@code TypedLiteral} defines the behavior common to literals that have a type
 * associated with them.
 * <pre>
 * listLiteral ::={@link ListLiteral listLiteral}| {@link MapLiteral mapLiteral}</pre>
 */
abstract class TypedLiteral extends Literal {
  /**
   * The const modifier associated with this literal, or {@code null} if the literal is not a
   * constant.
   */
  Token _modifier;
  /**
   * The type argument associated with this literal, or {@code null} if no type arguments were
   * declared.
   */
  TypeArgumentList _typeArguments;
  /**
   * Initialize a newly created typed literal.
   * @param modifier the const modifier associated with this literal
   * @param typeArguments the type argument associated with this literal, or {@code null} if no type
   * arguments were declared
   */
  TypedLiteral(Token modifier, TypeArgumentList typeArguments) {
    this._modifier = modifier;
    this._typeArguments = becomeParentOf(typeArguments);
  }
  /**
   * Return the const modifier associated with this literal.
   * @return the const modifier associated with this literal
   */
  Token get modifier => _modifier;
  /**
   * Return the type argument associated with this literal, or {@code null} if no type arguments
   * were declared.
   * @return the type argument associated with this literal
   */
  TypeArgumentList get typeArguments => _typeArguments;
  /**
   * Set the modifiers associated with this literal to the given modifiers.
   * @param modifiers the modifiers associated with this literal
   */
  void set modifier2(Token modifier) {
    this._modifier = modifier;
  }
  /**
   * Set the type argument associated with this literal to the given arguments.
   * @param typeArguments the type argument associated with this literal
   */
  void set typeArguments3(TypeArgumentList typeArguments) {
    this._typeArguments = typeArguments;
  }
  void visitChildren(ASTVisitor<Object> visitor) {
    safelyVisitChild(_typeArguments, visitor);
  }
}
/**
 * Instances of the class {@code VariableDeclaration} represent an identifier that has an initial
 * value associated with it. Instances of this class are always children of the class{@link VariableDeclarationList}.
 * <pre>
 * variableDeclaration ::={@link SimpleIdentifier identifier} ('=' {@link Expression initialValue})?
 * </pre>
 */
class VariableDeclaration extends Declaration {
  /**
   * The name of the variable being declared.
   */
  SimpleIdentifier _name;
  /**
   * The equal sign separating the variable name from the initial value, or {@code null} if the
   * initial value was not specified.
   */
  Token _equals;
  /**
   * The expression used to compute the initial value for the variable, or {@code null} if the
   * initial value was not specified.
   */
  Expression _initializer;
  /**
   * Initialize a newly created variable declaration.
   * @param comment the documentation comment associated with this declaration
   * @param metadata the annotations associated with this member
   * @param name the name of the variable being declared
   * @param equals the equal sign separating the variable name from the initial value
   * @param initializer the expression used to compute the initial value for the variable
   */
  VariableDeclaration(Comment comment, List<Annotation> metadata, SimpleIdentifier name, Token equals, Expression initializer) : super(comment, metadata) {
    this._name = becomeParentOf(name);
    this._equals = equals;
    this._initializer = becomeParentOf(initializer);
  }
  accept(ASTVisitor visitor) => visitor.visitVariableDeclaration(this);
  /**
   * Return the {@link VariableElement} associated with this variable, or {@code null} if the AST
   * structure has not been resolved.
   * @return the {@link VariableElement} associated with this variable
   */
  VariableElement get element => _name != null ? _name.element as VariableElement : null;
  Token get endToken {
    if (_initializer != null) {
      return _initializer.endToken;
    }
    return _name.endToken;
  }
  /**
   * Return the equal sign separating the variable name from the initial value, or {@code null} if
   * the initial value was not specified.
   * @return the equal sign separating the variable name from the initial value
   */
  Token get equals => _equals;
  /**
   * Return the expression used to compute the initial value for the variable, or {@code null} if
   * the initial value was not specified.
   * @return the expression used to compute the initial value for the variable
   */
  Expression get initializer => _initializer;
  /**
   * Return the name of the variable being declared.
   * @return the name of the variable being declared
   */
  SimpleIdentifier get name => _name;
  /**
   * Set the equal sign separating the variable name from the initial value to the given token.
   * @param equals the equal sign separating the variable name from the initial value
   */
  void set equals6(Token equals) {
    this._equals = equals;
  }
  /**
   * Set the expression used to compute the initial value for the variable to the given expression.
   * @param initializer the expression used to compute the initial value for the variable
   */
  void set initializer2(Expression initializer) {
    this._initializer = becomeParentOf(initializer);
  }
  /**
   * Set the name of the variable being declared to the given identifier.
   * @param name the name of the variable being declared
   */
  void set name14(SimpleIdentifier name) {
    this._name = becomeParentOf(name);
  }
  void visitChildren(ASTVisitor<Object> visitor) {
    super.visitChildren(visitor);
    safelyVisitChild(_name, visitor);
    safelyVisitChild(_initializer, visitor);
  }
  Token get firstTokenAfterCommentAndMetadata => _name.beginToken;
}
/**
 * Instances of the class {@code VariableDeclarationList} represent the declaration of one or more
 * variables of the same type.
 * <pre>
 * variableDeclarationList ::=
 * finalConstVarOrType {@link VariableDeclaration variableDeclaration} (',' {@link VariableDeclaration variableDeclaration})
 * finalConstVarOrType ::=
 * | 'final' {@link TypeName type}?
 * | 'const' {@link TypeName type}?
 * | 'var'
 * | {@link TypeName type}</pre>
 */
class VariableDeclarationList extends ASTNode {
  /**
   * The token representing the 'final', 'const' or 'var' keyword, or {@code null} if no keyword was
   * included.
   */
  Token _keyword;
  /**
   * The type of the variables being declared, or {@code null} if no type was provided.
   */
  TypeName _type;
  /**
   * A list containing the individual variables being declared.
   */
  NodeList<VariableDeclaration> _variables;
  /**
   * Initialize a newly created variable declaration list.
   * @param keyword the token representing the 'final', 'const' or 'var' keyword
   * @param type the type of the variables being declared
   * @param variables a list containing the individual variables being declared
   */
  VariableDeclarationList(Token keyword, TypeName type, List<VariableDeclaration> variables) {
    this._variables = new NodeList<VariableDeclaration>(this);
    this._keyword = keyword;
    this._type = becomeParentOf(type);
    this._variables.addAll(variables);
  }
  accept(ASTVisitor visitor) => visitor.visitVariableDeclarationList(this);
  Token get beginToken {
    if (_keyword != null) {
      return _keyword;
    } else if (_type != null) {
      return _type.beginToken;
    }
    return _variables.beginToken;
  }
  Token get endToken => _variables.endToken;
  /**
   * Return the token representing the 'final', 'const' or 'var' keyword, or {@code null} if no
   * keyword was included.
   * @return the token representing the 'final', 'const' or 'var' keyword
   */
  Token get keyword => _keyword;
  /**
   * Return the type of the variables being declared, or {@code null} if no type was provided.
   * @return the type of the variables being declared
   */
  TypeName get type => _type;
  /**
   * Return a list containing the individual variables being declared.
   * @return a list containing the individual variables being declared
   */
  NodeList<VariableDeclaration> get variables => _variables;
  /**
   * Set the token representing the 'final', 'const' or 'var' keyword to the given token.
   * @param keyword the token representing the 'final', 'const' or 'var' keyword
   */
  void set keyword25(Token keyword) {
    this._keyword = keyword;
  }
  /**
   * Set the type of the variables being declared to the given type name.
   * @param typeName the type of the variables being declared
   */
  void set type8(TypeName typeName) {
    _type = becomeParentOf(typeName);
  }
  void visitChildren(ASTVisitor<Object> visitor) {
    safelyVisitChild(_type, visitor);
    _variables.accept(visitor);
  }
}
/**
 * Instances of the class {@code VariableDeclarationStatement} represent a list of variables that
 * are being declared in a context where a statement is required.
 * <pre>
 * variableDeclarationStatement ::={@link VariableDeclarationList variableList} ';'
 * </pre>
 */
class VariableDeclarationStatement extends Statement {
  /**
   * The variables being declared.
   */
  VariableDeclarationList _variableList;
  /**
   * The semicolon terminating the statement.
   */
  Token _semicolon;
  /**
   * Initialize a newly created variable declaration statement.
   * @param variableList the fields being declared
   * @param semicolon the semicolon terminating the statement
   */
  VariableDeclarationStatement(VariableDeclarationList variableList, Token semicolon) {
    this._variableList = becomeParentOf(variableList);
    this._semicolon = semicolon;
  }
  accept(ASTVisitor visitor) => visitor.visitVariableDeclarationStatement(this);
  Token get beginToken => _variableList.beginToken;
  Token get endToken => _semicolon;
  /**
   * Return the semicolon terminating the statement.
   * @return the semicolon terminating the statement
   */
  Token get semicolon => _semicolon;
  /**
   * Return the variables being declared.
   * @return the variables being declared
   */
  VariableDeclarationList get variables => _variableList;
  /**
   * Set the semicolon terminating the statement to the given token.
   * @param semicolon the semicolon terminating the statement
   */
  void set semicolon18(Token semicolon) {
    this._semicolon = semicolon;
  }
  /**
   * Set the variables being declared to the given list of variables.
   * @param variableList the variables being declared
   */
  void set variables4(VariableDeclarationList variableList) {
    this._variableList = becomeParentOf(variableList);
  }
  void visitChildren(ASTVisitor<Object> visitor) {
    safelyVisitChild(_variableList, visitor);
  }
}
/**
 * Instances of the class {@code WhileStatement} represent a while statement.
 * <pre>
 * whileStatement ::=
 * 'while' '(' {@link Expression condition} ')' {@link Statement body}</pre>
 */
class WhileStatement extends Statement {
  /**
   * The token representing the 'while' keyword.
   */
  Token _keyword;
  /**
   * The left parenthesis.
   */
  Token _leftParenthesis;
  /**
   * The expression used to determine whether to execute the body of the loop.
   */
  Expression _condition;
  /**
   * The right parenthesis.
   */
  Token _rightParenthesis;
  /**
   * The body of the loop.
   */
  Statement _body;
  /**
   * Initialize a newly created while statement.
   * @param keyword the token representing the 'while' keyword
   * @param leftParenthesis the left parenthesis
   * @param condition the expression used to determine whether to execute the body of the loop
   * @param rightParenthesis the right parenthesis
   * @param body the body of the loop
   */
  WhileStatement(Token keyword, Token leftParenthesis, Expression condition, Token rightParenthesis, Statement body) {
    this._keyword = keyword;
    this._leftParenthesis = leftParenthesis;
    this._condition = becomeParentOf(condition);
    this._rightParenthesis = rightParenthesis;
    this._body = becomeParentOf(body);
  }
  accept(ASTVisitor visitor) => visitor.visitWhileStatement(this);
  Token get beginToken => _keyword;
  /**
   * Return the body of the loop.
   * @return the body of the loop
   */
  Statement get body => _body;
  /**
   * Return the expression used to determine whether to execute the body of the loop.
   * @return the expression used to determine whether to execute the body of the loop
   */
  Expression get condition => _condition;
  Token get endToken => _body.endToken;
  /**
   * Return the token representing the 'while' keyword.
   * @return the token representing the 'while' keyword
   */
  Token get keyword => _keyword;
  /**
   * Return the left parenthesis.
   * @return the left parenthesis
   */
  Token get leftParenthesis => _leftParenthesis;
  /**
   * Return the right parenthesis.
   * @return the right parenthesis
   */
  Token get rightParenthesis => _rightParenthesis;
  /**
   * Set the body of the loop to the given statement.
   * @param statement the body of the loop
   */
  void set body10(Statement statement) {
    _body = becomeParentOf(statement);
  }
  /**
   * Set the expression used to determine whether to execute the body of the loop to the given
   * expression.
   * @param expression the expression used to determine whether to execute the body of the loop
   */
  void set condition7(Expression expression) {
    _condition = becomeParentOf(expression);
  }
  /**
   * Set the token representing the 'while' keyword to the given token.
   * @param keyword the token representing the 'while' keyword
   */
  void set keyword26(Token keyword) {
    this._keyword = keyword;
  }
  /**
   * Set the left parenthesis to the given token.
   * @param leftParenthesis the left parenthesis
   */
  void set leftParenthesis12(Token leftParenthesis) {
    this._leftParenthesis = leftParenthesis;
  }
  /**
   * Set the right parenthesis to the given token.
   * @param rightParenthesis the right parenthesis
   */
  void set rightParenthesis12(Token rightParenthesis) {
    this._rightParenthesis = rightParenthesis;
  }
  void visitChildren(ASTVisitor<Object> visitor) {
    safelyVisitChild(_condition, visitor);
    safelyVisitChild(_body, visitor);
  }
}
/**
 * Instances of the class {@code WithClause} represent the with clause in a class declaration.
 * <pre>
 * withClause ::=
 * 'with' {@link TypeName mixin} (',' {@link TypeName mixin})
 * </pre>
 */
class WithClause extends ASTNode {
  /**
   * The token representing the 'with' keyword.
   */
  Token _withKeyword;
  /**
   * The names of the mixins that were specified.
   */
  NodeList<TypeName> _mixinTypes;
  /**
   * Initialize a newly created with clause.
   * @param withKeyword the token representing the 'with' keyword
   * @param mixinTypes the names of the mixins that were specified
   */
  WithClause(Token withKeyword, List<TypeName> mixinTypes) {
    this._mixinTypes = new NodeList<TypeName>(this);
    this._withKeyword = withKeyword;
    this._mixinTypes.addAll(mixinTypes);
  }
  accept(ASTVisitor visitor) => visitor.visitWithClause(this);
  Token get beginToken => _withKeyword;
  Token get endToken => _mixinTypes.endToken;
  /**
   * Return the names of the mixins that were specified.
   * @return the names of the mixins that were specified
   */
  NodeList<TypeName> get mixinTypes => _mixinTypes;
  /**
   * Return the token representing the 'with' keyword.
   * @return the token representing the 'with' keyword
   */
  Token get withKeyword => _withKeyword;
  /**
   * Set the token representing the 'with' keyword to the given token.
   * @param withKeyword the token representing the 'with' keyword
   */
  void set mixinKeyword(Token withKeyword) {
    this._withKeyword = withKeyword;
  }
  void visitChildren(ASTVisitor<Object> visitor) {
    _mixinTypes.accept(visitor);
  }
}
/**
 * Instances of the class {@code ConstantEvaluator} evaluate constant expressions to produce their
 * compile-time value. According to the Dart Language Specification: <blockquote> A constant
 * expression is one of the following:
 * <ul>
 * <li>A literal number.</li>
 * <li>A literal boolean.</li>
 * <li>A literal string where any interpolated expression is a compile-time constant that evaluates
 * to a numeric, string or boolean value or to {@code null}.</li>
 * <li>{@code null}.</li>
 * <li>A reference to a static constant variable.</li>
 * <li>An identifier expression that denotes a constant variable, a class or a type variable.</li>
 * <li>A constant constructor invocation.</li>
 * <li>A constant list literal.</li>
 * <li>A constant map literal.</li>
 * <li>A simple or qualified identifier denoting a top-level function or a static method.</li>
 * <li>A parenthesized expression {@code (e)} where {@code e} is a constant expression.</li>
 * <li>An expression of one of the forms {@code identical(e1, e2)}, {@code e1 == e2},{@code e1 != e2} where {@code e1} and {@code e2} are constant expressions that evaluate to a
 * numeric, string or boolean value or to {@code null}.</li>
 * <li>An expression of one of the forms {@code !e}, {@code e1 && e2} or {@code e1 || e2}, where{@code e}, {@code e1} and {@code e2} are constant expressions that evaluate to a boolean value or
 * to {@code null}.</li>
 * <li>An expression of one of the forms {@code ~e}, {@code e1 ^ e2}, {@code e1 & e2},{@code e1 | e2}, {@code e1 >> e2} or {@code e1 << e2}, where {@code e}, {@code e1} and {@code e2}are constant expressions that evaluate to an integer value or to {@code null}.</li>
 * <li>An expression of one of the forms {@code -e}, {@code e1 + e2}, {@code e1 - e2},{@code e1 * e2}, {@code e1 / e2}, {@code e1 ~/ e2}, {@code e1 > e2}, {@code e1 < e2},{@code e1 >= e2}, {@code e1 <= e2} or {@code e1 % e2}, where {@code e}, {@code e1} and {@code e2}are constant expressions that evaluate to a numeric value or to {@code null}.</li>
 * </ul>
 * </blockquote> The values returned by instances of this class are therefore {@code null} and
 * instances of the classes {@code Boolean}, {@code BigInteger}, {@code Double}, {@code String}, and{@code DartObject}.
 * <p>
 * In addition, this class defines several values that can be returned to indicate various
 * conditions encountered during evaluation. These are documented with the static field that define
 * those values.
 */
class ConstantEvaluator extends GeneralizingASTVisitor<Object> {
  /**
   * The value returned for expressions (or non-expression nodes) that are not compile-time constant
   * expressions.
   */
  static Object NOT_A_CONSTANT = new Object();
  Object visitAdjacentStrings(AdjacentStrings node) {
    StringBuffer builder = new StringBuffer();
    for (StringLiteral string in node.strings) {
      Object value = string.accept(this);
      if (value == ConstantEvaluator.NOT_A_CONSTANT) {
        return value;
      }
      builder.add(value);
    }
    return builder.toString();
  }
  Object visitBinaryExpression(BinaryExpression node) {
    Object leftOperand3 = node.leftOperand.accept(this);
    if (leftOperand3 == ConstantEvaluator.NOT_A_CONSTANT) {
      return leftOperand3;
    }
    Object rightOperand3 = node.rightOperand.accept(this);
    if (rightOperand3 == ConstantEvaluator.NOT_A_CONSTANT) {
      return rightOperand3;
    }
    if (node.operator.type == TokenType.AMPERSAND) {
      if (leftOperand3 is int && rightOperand3 is int) {
        return (leftOperand3 as int) & rightOperand3 as int;
      }
    } else if (node.operator.type == TokenType.AMPERSAND_AMPERSAND) {
      if (leftOperand3 is bool && rightOperand3 is bool) {
        return (leftOperand3 as bool) && (rightOperand3 as bool);
      }
    } else if (node.operator.type == TokenType.BANG_EQ) {
      if (leftOperand3 is bool && rightOperand3 is bool) {
        return (leftOperand3 as bool) != (rightOperand3 as bool);
      } else if (leftOperand3 is int && rightOperand3 is int) {
        return (leftOperand3 as int) != rightOperand3;
      } else if (leftOperand3 is double && rightOperand3 is double) {
        return (leftOperand3 as double) != rightOperand3;
      } else if (leftOperand3 is String && rightOperand3 is String) {
        return (leftOperand3 as String) != rightOperand3;
      }
    } else if (node.operator.type == TokenType.BAR) {
      if (leftOperand3 is int && rightOperand3 is int) {
        return (leftOperand3 as int) | rightOperand3 as int;
      }
    } else if (node.operator.type == TokenType.BAR_BAR) {
      if (leftOperand3 is bool && rightOperand3 is bool) {
        return (leftOperand3 as bool) || (rightOperand3 as bool);
      }
    } else if (node.operator.type == TokenType.CARET) {
      if (leftOperand3 is int && rightOperand3 is int) {
        return (leftOperand3 as int) ^ rightOperand3 as int;
      }
    } else if (node.operator.type == TokenType.EQ_EQ) {
      if (leftOperand3 is bool && rightOperand3 is bool) {
        return (leftOperand3 as bool) == (rightOperand3 as bool);
      } else if (leftOperand3 is int && rightOperand3 is int) {
        return (leftOperand3 as int) == rightOperand3;
      } else if (leftOperand3 is double && rightOperand3 is double) {
        return (leftOperand3 as double) == rightOperand3;
      } else if (leftOperand3 is String && rightOperand3 is String) {
        return (leftOperand3 as String) == rightOperand3;
      }
    } else if (node.operator.type == TokenType.GT) {
      if (leftOperand3 is int && rightOperand3 is int) {
        return (leftOperand3 as int).compareTo(rightOperand3 as int) > 0;
      } else if (leftOperand3 is double && rightOperand3 is double) {
        return (leftOperand3 as double).compareTo(rightOperand3 as double) > 0;
      }
    } else if (node.operator.type == TokenType.GT_EQ) {
      if (leftOperand3 is int && rightOperand3 is int) {
        return (leftOperand3 as int).compareTo(rightOperand3 as int) >= 0;
      } else if (leftOperand3 is double && rightOperand3 is double) {
        return (leftOperand3 as double).compareTo(rightOperand3 as double) >= 0;
      }
    } else if (node.operator.type == TokenType.GT_GT) {
      if (leftOperand3 is int && rightOperand3 is int) {
        return (leftOperand3 as int) >> (rightOperand3 as int);
      }
    } else if (node.operator.type == TokenType.LT) {
      if (leftOperand3 is int && rightOperand3 is int) {
        return (leftOperand3 as int).compareTo(rightOperand3 as int) < 0;
      } else if (leftOperand3 is double && rightOperand3 is double) {
        return (leftOperand3 as double).compareTo(rightOperand3 as double) < 0;
      }
    } else if (node.operator.type == TokenType.LT_EQ) {
      if (leftOperand3 is int && rightOperand3 is int) {
        return (leftOperand3 as int).compareTo(rightOperand3 as int) <= 0;
      } else if (leftOperand3 is double && rightOperand3 is double) {
        return (leftOperand3 as double).compareTo(rightOperand3 as double) <= 0;
      }
    } else if (node.operator.type == TokenType.LT_LT) {
      if (leftOperand3 is int && rightOperand3 is int) {
        return (leftOperand3 as int) << (rightOperand3 as int);
      }
    } else if (node.operator.type == TokenType.MINUS) {
      if (leftOperand3 is int && rightOperand3 is int) {
        return (leftOperand3 as int) - rightOperand3 as int;
      } else if (leftOperand3 is double && rightOperand3 is double) {
        return (leftOperand3 as double) - (rightOperand3 as double);
      }
    } else if (node.operator.type == TokenType.PERCENT) {
      if (leftOperand3 is int && rightOperand3 is int) {
        return (leftOperand3 as int).remainder(rightOperand3 as int);
      } else if (leftOperand3 is double && rightOperand3 is double) {
        return (leftOperand3 as double) % (rightOperand3 as double);
      }
    } else if (node.operator.type == TokenType.PLUS) {
      if (leftOperand3 is int && rightOperand3 is int) {
        return (leftOperand3 as int) + rightOperand3 as int;
      } else if (leftOperand3 is double && rightOperand3 is double) {
        return (leftOperand3 as double) + (rightOperand3 as double);
      }
    } else if (node.operator.type == TokenType.STAR) {
      if (leftOperand3 is int && rightOperand3 is int) {
        return (leftOperand3 as int) * rightOperand3 as int;
      } else if (leftOperand3 is double && rightOperand3 is double) {
        return (leftOperand3 as double) * (rightOperand3 as double);
      }
    } else if (node.operator.type == TokenType.SLASH) {
      if (leftOperand3 is int && rightOperand3 is int) {
        return (leftOperand3 as int) / rightOperand3 as int;
      } else if (leftOperand3 is double && rightOperand3 is double) {
        return (leftOperand3 as double) / (rightOperand3 as double);
      }
    } else if (node.operator.type == TokenType.TILDE_SLASH) {
      if (leftOperand3 is int && rightOperand3 is int) {
        return (leftOperand3 as int) / rightOperand3 as int;
      } else if (leftOperand3 is double && rightOperand3 is double) {
        return (leftOperand3 as double) ~/ (rightOperand3 as double);
      }
    }
    return visitExpression(node);
  }
  Object visitBooleanLiteral(BooleanLiteral node) => node.value ? true : false;
  Object visitDoubleLiteral(DoubleLiteral node) => node.value;
  Object visitIntegerLiteral(IntegerLiteral node) => node.value;
  Object visitInterpolationExpression(InterpolationExpression node) {
    Object value = node.expression.accept(this);
    if (value == null || value is bool || value is String || value is int || value is double) {
      return value;
    }
    return NOT_A_CONSTANT;
  }
  Object visitInterpolationString(InterpolationString node) => node.value;
  Object visitListLiteral(ListLiteral node) {
    List<Object> list = new List<Object>();
    for (Expression element in node.elements) {
      Object value = element.accept(this);
      if (value == ConstantEvaluator.NOT_A_CONSTANT) {
        return value;
      }
      list.add(value);
    }
    return list;
  }
  Object visitMapLiteral(MapLiteral node) {
    Map<String, Object> map = new Map<String, Object>();
    for (MapLiteralEntry entry in node.entries) {
      Object key3 = entry.key.accept(this);
      Object value10 = entry.value.accept(this);
      if (key3 is! String || value10 == ConstantEvaluator.NOT_A_CONSTANT) {
        return NOT_A_CONSTANT;
      }
      map[key3 as String] = value10;
    }
    return map;
  }
  Object visitMethodInvocation(MethodInvocation node) => visitNode(node);
  Object visitNode(ASTNode node) => NOT_A_CONSTANT;
  Object visitNullLiteral(NullLiteral node) => null;
  Object visitParenthesizedExpression(ParenthesizedExpression node) => node.expression.accept(this);
  Object visitPrefixedIdentifier(PrefixedIdentifier node) => getConstantValue(null);
  Object visitPrefixExpression(PrefixExpression node) {
    Object operand4 = node.operand.accept(this);
    if (operand4 == ConstantEvaluator.NOT_A_CONSTANT) {
      return operand4;
    }
    if (node.operator.type == TokenType.BANG) {
      if (operand4 == true) {
        return false;
      } else if (operand4 == false) {
        return true;
      }
    } else if (node.operator.type == TokenType.TILDE) {
      if (operand4 is int) {
        return ~(operand4 as int);
      }
    } else if (node.operator.type == TokenType.MINUS) {
      if (operand4 == null) {
        return null;
      } else if (operand4 is int) {
        return -(operand4 as int);
      } else if (operand4 is double) {
        return -(operand4 as double);
      }
    }
    return NOT_A_CONSTANT;
  }
  Object visitPropertyAccess(PropertyAccess node) => getConstantValue(null);
  Object visitSimpleIdentifier(SimpleIdentifier node) => getConstantValue(null);
  Object visitSimpleStringLiteral(SimpleStringLiteral node) => node.value;
  Object visitStringInterpolation(StringInterpolation node) {
    StringBuffer builder = new StringBuffer();
    for (InterpolationElement element in node.elements) {
      Object value = element.accept(this);
      if (value == ConstantEvaluator.NOT_A_CONSTANT) {
        return value;
      }
      builder.add(value);
    }
    return builder.toString();
  }
  /**
   * Return the constant value of the static constant represented by the given element.
   * @param element the element whose value is to be returned
   * @return the constant value of the static constant
   */
  Object getConstantValue(Element element) {
    if (element is FieldElement) {
      FieldElement field = element as FieldElement;
      if (field.isStatic() && field.isConst()) {
      }
    }
    return NOT_A_CONSTANT;
  }
}
/**
 * Instances of the class {@code GeneralizingASTVisitor} implement an AST visitor that will
 * recursively visit all of the nodes in an AST structure (like instances of the class{@link RecursiveASTVisitor}). In addition, when a node of a specific type is visited not only
 * will the visit method for that specific type of node be invoked, but additional methods for the
 * superclasses of that node will also be invoked. For example, using an instance of this class to
 * visit a {@link Block} will cause the method {@link #visitBlock(Block)} to be invoked but will
 * also cause the methods {@link #visitStatement(Statement)} and {@link #visitNode(ASTNode)} to be
 * subsequently invoked. This allows visitors to be written that visit all statements without
 * needing to override the visit method for each of the specific subclasses of {@link Statement}.
 * <p>
 * Subclasses that override a visit method must either invoke the overridden visit method or
 * explicitly invoke the more general visit method. Failure to do so will cause the visit methods
 * for superclasses of the node to not be invoked and will cause the children of the visited node to
 * not be visited.
 */
class GeneralizingASTVisitor<R> implements ASTVisitor<R> {
  R visitAdjacentStrings(AdjacentStrings node) => visitStringLiteral(node);
  R visitAnnotatedNode(AnnotatedNode node) => visitNode(node);
  R visitAnnotation(Annotation node) => visitNode(node);
  R visitArgumentDefinitionTest(ArgumentDefinitionTest node) => visitExpression(node);
  R visitArgumentList(ArgumentList node) => visitNode(node);
  R visitAsExpression(AsExpression node) => visitExpression(node);
  R visitAssertStatement(AssertStatement node) => visitStatement(node);
  R visitAssignmentExpression(AssignmentExpression node) => visitExpression(node);
  R visitBinaryExpression(BinaryExpression node) => visitExpression(node);
  R visitBlock(Block node) => visitStatement(node);
  R visitBlockFunctionBody(BlockFunctionBody node) => visitFunctionBody(node);
  R visitBooleanLiteral(BooleanLiteral node) => visitLiteral(node);
  R visitBreakStatement(BreakStatement node) => visitStatement(node);
  R visitCascadeExpression(CascadeExpression node) => visitExpression(node);
  R visitCatchClause(CatchClause node) => visitNode(node);
  R visitClassDeclaration(ClassDeclaration node) => visitCompilationUnitMember(node);
  R visitClassMember(ClassMember node) => visitDeclaration(node);
  R visitClassTypeAlias(ClassTypeAlias node) => visitTypeAlias(node);
  R visitCombinator(Combinator node) => visitNode(node);
  R visitComment(Comment node) => visitNode(node);
  R visitCommentReference(CommentReference node) => visitNode(node);
  R visitCompilationUnit(CompilationUnit node) => visitNode(node);
  R visitCompilationUnitMember(CompilationUnitMember node) => visitDeclaration(node);
  R visitConditionalExpression(ConditionalExpression node) => visitExpression(node);
  R visitConstructorDeclaration(ConstructorDeclaration node) => visitClassMember(node);
  R visitConstructorFieldInitializer(ConstructorFieldInitializer node) => visitConstructorInitializer(node);
  R visitConstructorInitializer(ConstructorInitializer node) => visitNode(node);
  R visitConstructorName(ConstructorName node) => visitNode(node);
  R visitContinueStatement(ContinueStatement node) => visitStatement(node);
  R visitDeclaration(Declaration node) => visitAnnotatedNode(node);
  R visitDefaultFormalParameter(DefaultFormalParameter node) => visitFormalParameter(node);
  R visitDirective(Directive node) => visitAnnotatedNode(node);
  R visitDoStatement(DoStatement node) => visitStatement(node);
  R visitDoubleLiteral(DoubleLiteral node) => visitLiteral(node);
  R visitEmptyFunctionBody(EmptyFunctionBody node) => visitFunctionBody(node);
  R visitEmptyStatement(EmptyStatement node) => visitStatement(node);
  R visitExportDirective(ExportDirective node) => visitNamespaceDirective(node);
  R visitExpression(Expression node) => visitNode(node);
  R visitExpressionFunctionBody(ExpressionFunctionBody node) => visitFunctionBody(node);
  R visitExpressionStatement(ExpressionStatement node) => visitStatement(node);
  R visitExtendsClause(ExtendsClause node) => visitNode(node);
  R visitFieldDeclaration(FieldDeclaration node) => visitClassMember(node);
  R visitFieldFormalParameter(FieldFormalParameter node) => visitNormalFormalParameter(node);
  R visitForEachStatement(ForEachStatement node) => visitStatement(node);
  R visitFormalParameter(FormalParameter node) => visitNode(node);
  R visitFormalParameterList(FormalParameterList node) => visitNode(node);
  R visitForStatement(ForStatement node) => visitStatement(node);
  R visitFunctionBody(FunctionBody node) => visitNode(node);
  R visitFunctionDeclaration(FunctionDeclaration node) => visitNode(node);
  R visitFunctionDeclarationStatement(FunctionDeclarationStatement node) => visitStatement(node);
  R visitFunctionExpression(FunctionExpression node) => visitExpression(node);
  R visitFunctionExpressionInvocation(FunctionExpressionInvocation node) => visitExpression(node);
  R visitFunctionTypeAlias(FunctionTypeAlias node) => visitTypeAlias(node);
  R visitFunctionTypedFormalParameter(FunctionTypedFormalParameter node) => visitNormalFormalParameter(node);
  R visitHideCombinator(HideCombinator node) => visitCombinator(node);
  R visitIdentifier(Identifier node) => visitExpression(node);
  R visitIfStatement(IfStatement node) => visitStatement(node);
  R visitImplementsClause(ImplementsClause node) => visitNode(node);
  R visitImportDirective(ImportDirective node) => visitNamespaceDirective(node);
  R visitIndexExpression(IndexExpression node) => visitExpression(node);
  R visitInstanceCreationExpression(InstanceCreationExpression node) => visitExpression(node);
  R visitIntegerLiteral(IntegerLiteral node) => visitLiteral(node);
  R visitInterpolationElement(InterpolationElement node) => visitNode(node);
  R visitInterpolationExpression(InterpolationExpression node) => visitInterpolationElement(node);
  R visitInterpolationString(InterpolationString node) => visitInterpolationElement(node);
  R visitIsExpression(IsExpression node) => visitExpression(node);
  R visitLabel(Label node) => visitNode(node);
  R visitLabeledStatement(LabeledStatement node) => visitStatement(node);
  R visitLibraryDirective(LibraryDirective node) => visitDirective(node);
  R visitLibraryIdentifier(LibraryIdentifier node) => visitIdentifier(node);
  R visitListLiteral(ListLiteral node) => visitTypedLiteral(node);
  R visitLiteral(Literal node) => visitExpression(node);
  R visitMapLiteral(MapLiteral node) => visitTypedLiteral(node);
  R visitMapLiteralEntry(MapLiteralEntry node) => visitNode(node);
  R visitMethodDeclaration(MethodDeclaration node) => visitClassMember(node);
  R visitMethodInvocation(MethodInvocation node) => visitNode(node);
  R visitNamedExpression(NamedExpression node) => visitExpression(node);
  R visitNamespaceDirective(NamespaceDirective node) => visitDirective(node);
  R visitNode(ASTNode node) {
    node.visitChildren(this);
    return null;
  }
  R visitNormalFormalParameter(NormalFormalParameter node) => visitFormalParameter(node);
  R visitNullLiteral(NullLiteral node) => visitLiteral(node);
  R visitParenthesizedExpression(ParenthesizedExpression node) => visitExpression(node);
  R visitPartDirective(PartDirective node) => visitDirective(node);
  R visitPartOfDirective(PartOfDirective node) => visitDirective(node);
  R visitPostfixExpression(PostfixExpression node) => visitExpression(node);
  R visitPrefixedIdentifier(PrefixedIdentifier node) => visitIdentifier(node);
  R visitPrefixExpression(PrefixExpression node) => visitExpression(node);
  R visitPropertyAccess(PropertyAccess node) => visitExpression(node);
  R visitRedirectingConstructorInvocation(RedirectingConstructorInvocation node) => visitConstructorInitializer(node);
  R visitReturnStatement(ReturnStatement node) => visitStatement(node);
  R visitScriptTag(ScriptTag scriptTag) => visitNode(scriptTag);
  R visitShowCombinator(ShowCombinator node) => visitCombinator(node);
  R visitSimpleFormalParameter(SimpleFormalParameter node) => visitNormalFormalParameter(node);
  R visitSimpleIdentifier(SimpleIdentifier node) => visitIdentifier(node);
  R visitSimpleStringLiteral(SimpleStringLiteral node) => visitStringLiteral(node);
  R visitStatement(Statement node) => visitNode(node);
  R visitStringInterpolation(StringInterpolation node) => visitStringLiteral(node);
  R visitStringLiteral(StringLiteral node) => visitLiteral(node);
  R visitSuperConstructorInvocation(SuperConstructorInvocation node) => visitConstructorInitializer(node);
  R visitSuperExpression(SuperExpression node) => visitExpression(node);
  R visitSwitchCase(SwitchCase node) => visitSwitchMember(node);
  R visitSwitchDefault(SwitchDefault node) => visitSwitchMember(node);
  R visitSwitchMember(SwitchMember node) => visitNode(node);
  R visitSwitchStatement(SwitchStatement node) => visitStatement(node);
  R visitThisExpression(ThisExpression node) => visitExpression(node);
  R visitThrowExpression(ThrowExpression node) => visitExpression(node);
  R visitTopLevelVariableDeclaration(TopLevelVariableDeclaration node) => visitCompilationUnitMember(node);
  R visitTryStatement(TryStatement node) => visitStatement(node);
  R visitTypeAlias(TypeAlias node) => visitCompilationUnitMember(node);
  R visitTypeArgumentList(TypeArgumentList node) => visitNode(node);
  R visitTypedLiteral(TypedLiteral node) => visitLiteral(node);
  R visitTypeName(TypeName node) => visitNode(node);
  R visitTypeParameter(TypeParameter node) => visitNode(node);
  R visitTypeParameterList(TypeParameterList node) => visitNode(node);
  R visitVariableDeclaration(VariableDeclaration node) => visitDeclaration(node);
  R visitVariableDeclarationList(VariableDeclarationList node) => visitNode(node);
  R visitVariableDeclarationStatement(VariableDeclarationStatement node) => visitStatement(node);
  R visitWhileStatement(WhileStatement node) => visitStatement(node);
  R visitWithClause(WithClause node) => visitNode(node);
}
/**
 * Instances of the class {@code NodeFoundException} are used to cancel visiting after a node has
 * been found.
 */
class NodeLocator_NodeFoundException extends RuntimeException {
  static int _serialVersionUID = 1;
}
/**
 * Instances of the class {@code RecursiveASTVisitor} implement an AST visitor that will recursively
 * visit all of the nodes in an AST structure. For example, using an instance of this class to visit
 * a {@link Block} will also cause all of the statements in the block to be visited.
 * <p>
 * Subclasses that override a visit method must either invoke the overridden visit method or must
 * explicitly ask the visited node to visit its children. Failure to do so will cause the children
 * of the visited node to not be visited.
 */
class RecursiveASTVisitor<R> implements ASTVisitor<R> {
  R visitAdjacentStrings(AdjacentStrings node) {
    node.visitChildren(this);
    return null;
  }
  R visitAnnotation(Annotation node) {
    node.visitChildren(this);
    return null;
  }
  R visitArgumentDefinitionTest(ArgumentDefinitionTest node) {
    node.visitChildren(this);
    return null;
  }
  R visitArgumentList(ArgumentList node) {
    node.visitChildren(this);
    return null;
  }
  R visitAsExpression(AsExpression node) {
    node.visitChildren(this);
    return null;
  }
  R visitAssertStatement(AssertStatement node) {
    node.visitChildren(this);
    return null;
  }
  R visitAssignmentExpression(AssignmentExpression node) {
    node.visitChildren(this);
    return null;
  }
  R visitBinaryExpression(BinaryExpression node) {
    node.visitChildren(this);
    return null;
  }
  R visitBlock(Block node) {
    node.visitChildren(this);
    return null;
  }
  R visitBlockFunctionBody(BlockFunctionBody node) {
    node.visitChildren(this);
    return null;
  }
  R visitBooleanLiteral(BooleanLiteral node) {
    node.visitChildren(this);
    return null;
  }
  R visitBreakStatement(BreakStatement node) {
    node.visitChildren(this);
    return null;
  }
  R visitCascadeExpression(CascadeExpression node) {
    node.visitChildren(this);
    return null;
  }
  R visitCatchClause(CatchClause node) {
    node.visitChildren(this);
    return null;
  }
  R visitClassDeclaration(ClassDeclaration node) {
    node.visitChildren(this);
    return null;
  }
  R visitClassTypeAlias(ClassTypeAlias node) {
    node.visitChildren(this);
    return null;
  }
  R visitComment(Comment node) {
    node.visitChildren(this);
    return null;
  }
  R visitCommentReference(CommentReference node) {
    node.visitChildren(this);
    return null;
  }
  R visitCompilationUnit(CompilationUnit node) {
    node.visitChildren(this);
    return null;
  }
  R visitConditionalExpression(ConditionalExpression node) {
    node.visitChildren(this);
    return null;
  }
  R visitConstructorDeclaration(ConstructorDeclaration node) {
    node.visitChildren(this);
    return null;
  }
  R visitConstructorFieldInitializer(ConstructorFieldInitializer node) {
    node.visitChildren(this);
    return null;
  }
  R visitConstructorName(ConstructorName node) {
    node.visitChildren(this);
    return null;
  }
  R visitContinueStatement(ContinueStatement node) {
    node.visitChildren(this);
    return null;
  }
  R visitDefaultFormalParameter(DefaultFormalParameter node) {
    node.visitChildren(this);
    return null;
  }
  R visitDoStatement(DoStatement node) {
    node.visitChildren(this);
    return null;
  }
  R visitDoubleLiteral(DoubleLiteral node) {
    node.visitChildren(this);
    return null;
  }
  R visitEmptyFunctionBody(EmptyFunctionBody node) {
    node.visitChildren(this);
    return null;
  }
  R visitEmptyStatement(EmptyStatement node) {
    node.visitChildren(this);
    return null;
  }
  R visitExportDirective(ExportDirective node) {
    node.visitChildren(this);
    return null;
  }
  R visitExpressionFunctionBody(ExpressionFunctionBody node) {
    node.visitChildren(this);
    return null;
  }
  R visitExpressionStatement(ExpressionStatement node) {
    node.visitChildren(this);
    return null;
  }
  R visitExtendsClause(ExtendsClause node) {
    node.visitChildren(this);
    return null;
  }
  R visitFieldDeclaration(FieldDeclaration node) {
    node.visitChildren(this);
    return null;
  }
  R visitFieldFormalParameter(FieldFormalParameter node) {
    node.visitChildren(this);
    return null;
  }
  R visitForEachStatement(ForEachStatement node) {
    node.visitChildren(this);
    return null;
  }
  R visitFormalParameterList(FormalParameterList node) {
    node.visitChildren(this);
    return null;
  }
  R visitForStatement(ForStatement node) {
    node.visitChildren(this);
    return null;
  }
  R visitFunctionDeclaration(FunctionDeclaration node) {
    node.visitChildren(this);
    return null;
  }
  R visitFunctionDeclarationStatement(FunctionDeclarationStatement node) {
    node.visitChildren(this);
    return null;
  }
  R visitFunctionExpression(FunctionExpression node) {
    node.visitChildren(this);
    return null;
  }
  R visitFunctionExpressionInvocation(FunctionExpressionInvocation node) {
    node.visitChildren(this);
    return null;
  }
  R visitFunctionTypeAlias(FunctionTypeAlias node) {
    node.visitChildren(this);
    return null;
  }
  R visitFunctionTypedFormalParameter(FunctionTypedFormalParameter node) {
    node.visitChildren(this);
    return null;
  }
  R visitHideCombinator(HideCombinator node) {
    node.visitChildren(this);
    return null;
  }
  R visitIfStatement(IfStatement node) {
    node.visitChildren(this);
    return null;
  }
  R visitImplementsClause(ImplementsClause node) {
    node.visitChildren(this);
    return null;
  }
  R visitImportDirective(ImportDirective node) {
    node.visitChildren(this);
    return null;
  }
  R visitIndexExpression(IndexExpression node) {
    node.visitChildren(this);
    return null;
  }
  R visitInstanceCreationExpression(InstanceCreationExpression node) {
    node.visitChildren(this);
    return null;
  }
  R visitIntegerLiteral(IntegerLiteral node) {
    node.visitChildren(this);
    return null;
  }
  R visitInterpolationExpression(InterpolationExpression node) {
    node.visitChildren(this);
    return null;
  }
  R visitInterpolationString(InterpolationString node) {
    node.visitChildren(this);
    return null;
  }
  R visitIsExpression(IsExpression node) {
    node.visitChildren(this);
    return null;
  }
  R visitLabel(Label node) {
    node.visitChildren(this);
    return null;
  }
  R visitLabeledStatement(LabeledStatement node) {
    node.visitChildren(this);
    return null;
  }
  R visitLibraryDirective(LibraryDirective node) {
    node.visitChildren(this);
    return null;
  }
  R visitLibraryIdentifier(LibraryIdentifier node) {
    node.visitChildren(this);
    return null;
  }
  R visitListLiteral(ListLiteral node) {
    node.visitChildren(this);
    return null;
  }
  R visitMapLiteral(MapLiteral node) {
    node.visitChildren(this);
    return null;
  }
  R visitMapLiteralEntry(MapLiteralEntry node) {
    node.visitChildren(this);
    return null;
  }
  R visitMethodDeclaration(MethodDeclaration node) {
    node.visitChildren(this);
    return null;
  }
  R visitMethodInvocation(MethodInvocation node) {
    node.visitChildren(this);
    return null;
  }
  R visitNamedExpression(NamedExpression node) {
    node.visitChildren(this);
    return null;
  }
  R visitNullLiteral(NullLiteral node) {
    node.visitChildren(this);
    return null;
  }
  R visitParenthesizedExpression(ParenthesizedExpression node) {
    node.visitChildren(this);
    return null;
  }
  R visitPartDirective(PartDirective node) {
    node.visitChildren(this);
    return null;
  }
  R visitPartOfDirective(PartOfDirective node) {
    node.visitChildren(this);
    return null;
  }
  R visitPostfixExpression(PostfixExpression node) {
    node.visitChildren(this);
    return null;
  }
  R visitPrefixedIdentifier(PrefixedIdentifier node) {
    node.visitChildren(this);
    return null;
  }
  R visitPrefixExpression(PrefixExpression node) {
    node.visitChildren(this);
    return null;
  }
  R visitPropertyAccess(PropertyAccess node) {
    node.visitChildren(this);
    return null;
  }
  R visitRedirectingConstructorInvocation(RedirectingConstructorInvocation node) {
    node.visitChildren(this);
    return null;
  }
  R visitReturnStatement(ReturnStatement node) {
    node.visitChildren(this);
    return null;
  }
  R visitScriptTag(ScriptTag node) {
    node.visitChildren(this);
    return null;
  }
  R visitShowCombinator(ShowCombinator node) {
    node.visitChildren(this);
    return null;
  }
  R visitSimpleFormalParameter(SimpleFormalParameter node) {
    node.visitChildren(this);
    return null;
  }
  R visitSimpleIdentifier(SimpleIdentifier node) {
    node.visitChildren(this);
    return null;
  }
  R visitSimpleStringLiteral(SimpleStringLiteral node) {
    node.visitChildren(this);
    return null;
  }
  R visitStringInterpolation(StringInterpolation node) {
    node.visitChildren(this);
    return null;
  }
  R visitSuperConstructorInvocation(SuperConstructorInvocation node) {
    node.visitChildren(this);
    return null;
  }
  R visitSuperExpression(SuperExpression node) {
    node.visitChildren(this);
    return null;
  }
  R visitSwitchCase(SwitchCase node) {
    node.visitChildren(this);
    return null;
  }
  R visitSwitchDefault(SwitchDefault node) {
    node.visitChildren(this);
    return null;
  }
  R visitSwitchStatement(SwitchStatement node) {
    node.visitChildren(this);
    return null;
  }
  R visitThisExpression(ThisExpression node) {
    node.visitChildren(this);
    return null;
  }
  R visitThrowExpression(ThrowExpression node) {
    node.visitChildren(this);
    return null;
  }
  R visitTopLevelVariableDeclaration(TopLevelVariableDeclaration node) {
    node.visitChildren(this);
    return null;
  }
  R visitTryStatement(TryStatement node) {
    node.visitChildren(this);
    return null;
  }
  R visitTypeArgumentList(TypeArgumentList node) {
    node.visitChildren(this);
    return null;
  }
  R visitTypeName(TypeName node) {
    node.visitChildren(this);
    return null;
  }
  R visitTypeParameter(TypeParameter node) {
    node.visitChildren(this);
    return null;
  }
  R visitTypeParameterList(TypeParameterList node) {
    node.visitChildren(this);
    return null;
  }
  R visitVariableDeclaration(VariableDeclaration node) {
    node.visitChildren(this);
    return null;
  }
  R visitVariableDeclarationList(VariableDeclarationList node) {
    node.visitChildren(this);
    return null;
  }
  R visitVariableDeclarationStatement(VariableDeclarationStatement node) {
    node.visitChildren(this);
    return null;
  }
  R visitWhileStatement(WhileStatement node) {
    node.visitChildren(this);
    return null;
  }
  R visitWithClause(WithClause node) {
    node.visitChildren(this);
    return null;
  }
}
/**
 * Instances of the class {@code SimpleASTVisitor} implement an AST visitor that will do nothing
 * when visiting an AST node. It is intended to be a superclass for classes that use the visitor
 * pattern primarily as a dispatch mechanism (and hence don't need to recursively visit a whole
 * structure) and that only need to visit a small number of node types.
 */
class SimpleASTVisitor<R> implements ASTVisitor<R> {
  R visitAdjacentStrings(AdjacentStrings node) => null;
  R visitAnnotation(Annotation node) => null;
  R visitArgumentDefinitionTest(ArgumentDefinitionTest node) => null;
  R visitArgumentList(ArgumentList node) => null;
  R visitAsExpression(AsExpression node) => null;
  R visitAssertStatement(AssertStatement node) => null;
  R visitAssignmentExpression(AssignmentExpression node) => null;
  R visitBinaryExpression(BinaryExpression node) => null;
  R visitBlock(Block node) => null;
  R visitBlockFunctionBody(BlockFunctionBody node) => null;
  R visitBooleanLiteral(BooleanLiteral node) => null;
  R visitBreakStatement(BreakStatement node) => null;
  R visitCascadeExpression(CascadeExpression node) => null;
  R visitCatchClause(CatchClause node) => null;
  R visitClassDeclaration(ClassDeclaration node) => null;
  R visitClassTypeAlias(ClassTypeAlias node) => null;
  R visitComment(Comment node) => null;
  R visitCommentReference(CommentReference node) => null;
  R visitCompilationUnit(CompilationUnit node) => null;
  R visitConditionalExpression(ConditionalExpression node) => null;
  R visitConstructorDeclaration(ConstructorDeclaration node) => null;
  R visitConstructorFieldInitializer(ConstructorFieldInitializer node) => null;
  R visitConstructorName(ConstructorName node) => null;
  R visitContinueStatement(ContinueStatement node) => null;
  R visitDefaultFormalParameter(DefaultFormalParameter node) => null;
  R visitDoStatement(DoStatement node) => null;
  R visitDoubleLiteral(DoubleLiteral node) => null;
  R visitEmptyFunctionBody(EmptyFunctionBody node) => null;
  R visitEmptyStatement(EmptyStatement node) => null;
  R visitExportDirective(ExportDirective node) => null;
  R visitExpressionFunctionBody(ExpressionFunctionBody node) => null;
  R visitExpressionStatement(ExpressionStatement node) => null;
  R visitExtendsClause(ExtendsClause node) => null;
  R visitFieldDeclaration(FieldDeclaration node) => null;
  R visitFieldFormalParameter(FieldFormalParameter node) => null;
  R visitForEachStatement(ForEachStatement node) => null;
  R visitFormalParameterList(FormalParameterList node) => null;
  R visitForStatement(ForStatement node) => null;
  R visitFunctionDeclaration(FunctionDeclaration node) => null;
  R visitFunctionDeclarationStatement(FunctionDeclarationStatement node) => null;
  R visitFunctionExpression(FunctionExpression node) => null;
  R visitFunctionExpressionInvocation(FunctionExpressionInvocation node) => null;
  R visitFunctionTypeAlias(FunctionTypeAlias node) => null;
  R visitFunctionTypedFormalParameter(FunctionTypedFormalParameter node) => null;
  R visitHideCombinator(HideCombinator node) => null;
  R visitIfStatement(IfStatement node) => null;
  R visitImplementsClause(ImplementsClause node) => null;
  R visitImportDirective(ImportDirective node) => null;
  R visitIndexExpression(IndexExpression node) => null;
  R visitInstanceCreationExpression(InstanceCreationExpression node) => null;
  R visitIntegerLiteral(IntegerLiteral node) => null;
  R visitInterpolationExpression(InterpolationExpression node) => null;
  R visitInterpolationString(InterpolationString node) => null;
  R visitIsExpression(IsExpression node) => null;
  R visitLabel(Label node) => null;
  R visitLabeledStatement(LabeledStatement node) => null;
  R visitLibraryDirective(LibraryDirective node) => null;
  R visitLibraryIdentifier(LibraryIdentifier node) => null;
  R visitListLiteral(ListLiteral node) => null;
  R visitMapLiteral(MapLiteral node) => null;
  R visitMapLiteralEntry(MapLiteralEntry node) => null;
  R visitMethodDeclaration(MethodDeclaration node) => null;
  R visitMethodInvocation(MethodInvocation node) => null;
  R visitNamedExpression(NamedExpression node) => null;
  R visitNullLiteral(NullLiteral node) => null;
  R visitParenthesizedExpression(ParenthesizedExpression node) => null;
  R visitPartDirective(PartDirective node) => null;
  R visitPartOfDirective(PartOfDirective node) => null;
  R visitPostfixExpression(PostfixExpression node) => null;
  R visitPrefixedIdentifier(PrefixedIdentifier node) => null;
  R visitPrefixExpression(PrefixExpression node) => null;
  R visitPropertyAccess(PropertyAccess node) => null;
  R visitRedirectingConstructorInvocation(RedirectingConstructorInvocation node) => null;
  R visitReturnStatement(ReturnStatement node) => null;
  R visitScriptTag(ScriptTag node) => null;
  R visitShowCombinator(ShowCombinator node) => null;
  R visitSimpleFormalParameter(SimpleFormalParameter node) => null;
  R visitSimpleIdentifier(SimpleIdentifier node) => null;
  R visitSimpleStringLiteral(SimpleStringLiteral node) => null;
  R visitStringInterpolation(StringInterpolation node) => null;
  R visitSuperConstructorInvocation(SuperConstructorInvocation node) => null;
  R visitSuperExpression(SuperExpression node) => null;
  R visitSwitchCase(SwitchCase node) => null;
  R visitSwitchDefault(SwitchDefault node) => null;
  R visitSwitchStatement(SwitchStatement node) => null;
  R visitThisExpression(ThisExpression node) => null;
  R visitThrowExpression(ThrowExpression node) => null;
  R visitTopLevelVariableDeclaration(TopLevelVariableDeclaration node) => null;
  R visitTryStatement(TryStatement node) => null;
  R visitTypeArgumentList(TypeArgumentList node) => null;
  R visitTypeName(TypeName node) => null;
  R visitTypeParameter(TypeParameter node) => null;
  R visitTypeParameterList(TypeParameterList node) => null;
  R visitVariableDeclaration(VariableDeclaration node) => null;
  R visitVariableDeclarationList(VariableDeclarationList node) => null;
  R visitVariableDeclarationStatement(VariableDeclarationStatement node) => null;
  R visitWhileStatement(WhileStatement node) => null;
  R visitWithClause(WithClause node) => null;
}
/**
 * Instances of the class {@code ToSourceVisitor} write a source representation of a visited AST
 * node (and all of it's children) to a writer.
 */
class ToSourceVisitor implements ASTVisitor<Object> {
  /**
   * The writer to which the source is to be written.
   */
  PrintWriter _writer;
  /**
   * Initialize a newly created visitor to write source code representing the visited nodes to the
   * given writer.
   * @param writer the writer to which the source is to be written
   */
  ToSourceVisitor(PrintWriter writer) {
    this._writer = writer;
  }
  Object visitAdjacentStrings(AdjacentStrings node) {
    visitList2(node.strings, " ");
    return null;
  }
  Object visitAnnotation(Annotation node) {
    _writer.print('@');
    visit(node.name);
    visit3(".", node.constructorName);
    visit(node.arguments);
    return null;
  }
  Object visitArgumentDefinitionTest(ArgumentDefinitionTest node) {
    _writer.print('?');
    visit(node.identifier);
    return null;
  }
  Object visitArgumentList(ArgumentList node) {
    _writer.print('(');
    visitList2(node.arguments, ", ");
    _writer.print(')');
    return null;
  }
  Object visitAsExpression(AsExpression node) {
    visit(node.expression);
    _writer.print(" as ");
    visit(node.type);
    return null;
  }
  Object visitAssertStatement(AssertStatement node) {
    _writer.print("assert (");
    visit(node.condition);
    _writer.print(");");
    return null;
  }
  Object visitAssignmentExpression(AssignmentExpression node) {
    visit(node.leftHandSide);
    _writer.print(' ');
    _writer.print(node.operator.lexeme);
    _writer.print(' ');
    visit(node.rightHandSide);
    return null;
  }
  Object visitBinaryExpression(BinaryExpression node) {
    visit(node.leftOperand);
    _writer.print(' ');
    _writer.print(node.operator.lexeme);
    _writer.print(' ');
    visit(node.rightOperand);
    return null;
  }
  Object visitBlock(Block node) {
    _writer.print('{');
    visitList2(node.statements, " ");
    _writer.print('}');
    return null;
  }
  Object visitBlockFunctionBody(BlockFunctionBody node) {
    visit(node.block);
    return null;
  }
  Object visitBooleanLiteral(BooleanLiteral node) {
    _writer.print(node.literal.lexeme);
    return null;
  }
  Object visitBreakStatement(BreakStatement node) {
    _writer.print("break");
    visit3(" ", node.label);
    _writer.print(";");
    return null;
  }
  Object visitCascadeExpression(CascadeExpression node) {
    visit(node.target);
    visitList(node.cascadeSections);
    return null;
  }
  Object visitCatchClause(CatchClause node) {
    visit3("on ", node.exceptionType);
    if (node.catchKeyword != null) {
      if (node.exceptionType != null) {
        _writer.print(' ');
      }
      _writer.print("catch (");
      visit(node.exceptionParameter);
      visit3(", ", node.stackTraceParameter);
      _writer.print(") ");
    } else {
      _writer.print(" ");
    }
    visit(node.body);
    return null;
  }
  Object visitClassDeclaration(ClassDeclaration node) {
    visit5(node.abstractKeyword, " ");
    _writer.print("class ");
    visit(node.name);
    visit(node.typeParameters);
    visit3(" ", node.extendsClause);
    visit3(" ", node.withClause);
    visit3(" ", node.implementsClause);
    _writer.print(" {");
    visitList2(node.members, " ");
    _writer.print("}");
    return null;
  }
  Object visitClassTypeAlias(ClassTypeAlias node) {
    _writer.print("typedef ");
    visit(node.name);
    visit(node.typeParameters);
    _writer.print(" = ");
    if (node.abstractKeyword != null) {
      _writer.print("abstract ");
    }
    visit(node.superclass);
    visit3(" ", node.withClause);
    visit3(" ", node.implementsClause);
    _writer.print(";");
    return null;
  }
  Object visitComment(Comment node) => null;
  Object visitCommentReference(CommentReference node) => null;
  Object visitCompilationUnit(CompilationUnit node) {
    ScriptTag scriptTag4 = node.scriptTag;
    NodeList<Directive> directives2 = node.directives;
    visit(scriptTag4);
    String prefix = scriptTag4 == null ? "" : " ";
    visitList4(prefix, directives2, " ");
    prefix = scriptTag4 == null && directives2.isEmpty ? "" : " ";
    visitList4(prefix, node.declarations, " ");
    return null;
  }
  Object visitConditionalExpression(ConditionalExpression node) {
    visit(node.condition);
    _writer.print(" ? ");
    visit(node.thenExpression);
    _writer.print(" : ");
    visit(node.elseExpression);
    return null;
  }
  Object visitConstructorDeclaration(ConstructorDeclaration node) {
    visit5(node.externalKeyword, " ");
    visit5(node.constKeyword, " ");
    visit5(node.factoryKeyword, " ");
    visit(node.returnType);
    visit3(".", node.name);
    visit(node.parameters);
    visitList4(" : ", node.initializers, ", ");
    visit3(" = ", node.redirectedConstructor);
    visit4(" ", node.body);
    return null;
  }
  Object visitConstructorFieldInitializer(ConstructorFieldInitializer node) {
    visit5(node.keyword, ".");
    visit(node.fieldName);
    _writer.print(" = ");
    visit(node.expression);
    return null;
  }
  Object visitConstructorName(ConstructorName node) {
    visit(node.type);
    visit3(".", node.name);
    return null;
  }
  Object visitContinueStatement(ContinueStatement node) {
    _writer.print("continue");
    visit3(" ", node.label);
    _writer.print(";");
    return null;
  }
  Object visitDefaultFormalParameter(DefaultFormalParameter node) {
    visit(node.parameter);
    if (node.separator != null) {
      _writer.print(" ");
      _writer.print(node.separator.lexeme);
      visit3(" ", node.defaultValue);
    }
    return null;
  }
  Object visitDoStatement(DoStatement node) {
    _writer.print("do ");
    visit(node.body);
    _writer.print(" while (");
    visit(node.condition);
    _writer.print(");");
    return null;
  }
  Object visitDoubleLiteral(DoubleLiteral node) {
    _writer.print(node.literal.lexeme);
    return null;
  }
  Object visitEmptyFunctionBody(EmptyFunctionBody node) {
    _writer.print(';');
    return null;
  }
  Object visitEmptyStatement(EmptyStatement node) {
    _writer.print(';');
    return null;
  }
  Object visitExportDirective(ExportDirective node) {
    _writer.print("export ");
    visit(node.libraryUri);
    visitList4(" ", node.combinators, " ");
    _writer.print(';');
    return null;
  }
  Object visitExpressionFunctionBody(ExpressionFunctionBody node) {
    _writer.print("=> ");
    visit(node.expression);
    if (node.semicolon != null) {
      _writer.print(';');
    }
    return null;
  }
  Object visitExpressionStatement(ExpressionStatement node) {
    visit(node.expression);
    _writer.print(';');
    return null;
  }
  Object visitExtendsClause(ExtendsClause node) {
    _writer.print("extends ");
    visit(node.superclass);
    return null;
  }
  Object visitFieldDeclaration(FieldDeclaration node) {
    visit5(node.keyword, " ");
    visit(node.fields);
    _writer.print(";");
    return null;
  }
  Object visitFieldFormalParameter(FieldFormalParameter node) {
    visit5(node.keyword, " ");
    visit2(node.type, " ");
    _writer.print("this.");
    visit(node.identifier);
    return null;
  }
  Object visitForEachStatement(ForEachStatement node) {
    _writer.print("for (");
    visit(node.loopParameter);
    _writer.print(" in ");
    visit(node.iterator);
    _writer.print(") ");
    visit(node.body);
    return null;
  }
  Object visitFormalParameterList(FormalParameterList node) {
    String groupEnd = null;
    _writer.print('(');
    NodeList<FormalParameter> parameters9 = node.parameters;
    int size2 = parameters9.length;
    for (int i = 0; i < size2; i++) {
      FormalParameter parameter = parameters9[i];
      if (i > 0) {
        _writer.print(", ");
      }
      if (groupEnd == null && parameter is DefaultFormalParameter) {
        if (parameter.kind == ParameterKind.NAMED) {
          groupEnd = "}";
          _writer.print('{');
        } else {
          groupEnd = "]";
          _writer.print('[');
        }
      }
      parameter.accept(this);
    }
    if (groupEnd != null) {
      _writer.print(groupEnd);
    }
    _writer.print(')');
    return null;
  }
  Object visitForStatement(ForStatement node) {
    Expression initialization3 = node.initialization;
    _writer.print("for (");
    if (initialization3 != null) {
      visit(initialization3);
    } else {
      visit(node.variables);
    }
    _writer.print(";");
    visit3(" ", node.condition);
    _writer.print(";");
    visitList4(" ", node.updaters, ", ");
    _writer.print(") ");
    visit(node.body);
    return null;
  }
  Object visitFunctionDeclaration(FunctionDeclaration node) {
    visit2(node.returnType, " ");
    visit5(node.propertyKeyword, " ");
    visit(node.name);
    visit(node.functionExpression);
    return null;
  }
  Object visitFunctionDeclarationStatement(FunctionDeclarationStatement node) {
    visit(node.functionDeclaration);
    _writer.print(';');
    return null;
  }
  Object visitFunctionExpression(FunctionExpression node) {
    visit(node.parameters);
    _writer.print(' ');
    visit(node.body);
    return null;
  }
  Object visitFunctionExpressionInvocation(FunctionExpressionInvocation node) {
    visit(node.function);
    visit(node.argumentList);
    return null;
  }
  Object visitFunctionTypeAlias(FunctionTypeAlias node) {
    _writer.print("typedef ");
    visit2(node.returnType, " ");
    visit(node.name);
    visit(node.typeParameters);
    visit(node.parameters);
    _writer.print(";");
    return null;
  }
  Object visitFunctionTypedFormalParameter(FunctionTypedFormalParameter node) {
    visit2(node.returnType, " ");
    visit(node.identifier);
    visit(node.parameters);
    return null;
  }
  Object visitHideCombinator(HideCombinator node) {
    _writer.print("hide ");
    visitList2(node.hiddenNames, ", ");
    return null;
  }
  Object visitIfStatement(IfStatement node) {
    _writer.print("if (");
    visit(node.condition);
    _writer.print(") ");
    visit(node.thenStatement);
    visit3(" else ", node.elseStatement);
    return null;
  }
  Object visitImplementsClause(ImplementsClause node) {
    _writer.print("implements ");
    visitList2(node.interfaces, ", ");
    return null;
  }
  Object visitImportDirective(ImportDirective node) {
    _writer.print("import ");
    visit(node.libraryUri);
    visit3(" as ", node.prefix);
    visitList4(" ", node.combinators, " ");
    _writer.print(';');
    return null;
  }
  Object visitIndexExpression(IndexExpression node) {
    if (node.isCascaded()) {
      _writer.print("..");
    } else {
      visit(node.array);
    }
    _writer.print('[');
    visit(node.index);
    _writer.print(']');
    return null;
  }
  Object visitInstanceCreationExpression(InstanceCreationExpression node) {
    visit5(node.keyword, " ");
    visit(node.constructorName);
    visit(node.argumentList);
    return null;
  }
  Object visitIntegerLiteral(IntegerLiteral node) {
    _writer.print(node.literal.lexeme);
    return null;
  }
  Object visitInterpolationExpression(InterpolationExpression node) {
    if (node.rightBracket != null) {
      _writer.print("\${");
      visit(node.expression);
      _writer.print("}");
    } else {
      _writer.print("\$");
      visit(node.expression);
    }
    return null;
  }
  Object visitInterpolationString(InterpolationString node) {
    _writer.print(node.contents.lexeme);
    return null;
  }
  Object visitIsExpression(IsExpression node) {
    visit(node.expression);
    if (node.notOperator == null) {
      _writer.print(" is ");
    } else {
      _writer.print(" is! ");
    }
    visit(node.type);
    return null;
  }
  Object visitLabel(Label node) {
    visit(node.label);
    _writer.print(":");
    return null;
  }
  Object visitLabeledStatement(LabeledStatement node) {
    visitList3(node.labels, " ", " ");
    visit(node.statement);
    return null;
  }
  Object visitLibraryDirective(LibraryDirective node) {
    _writer.print("library ");
    visit(node.name);
    _writer.print(';');
    return null;
  }
  Object visitLibraryIdentifier(LibraryIdentifier node) {
    _writer.print(node.name);
    return null;
  }
  Object visitListLiteral(ListLiteral node) {
    if (node.modifier != null) {
      _writer.print(node.modifier.lexeme);
      _writer.print(' ');
    }
    visit2(node.typeArguments, " ");
    _writer.print("[");
    visitList2(node.elements, ", ");
    _writer.print("]");
    return null;
  }
  Object visitMapLiteral(MapLiteral node) {
    if (node.modifier != null) {
      _writer.print(node.modifier.lexeme);
      _writer.print(' ');
    }
    visit2(node.typeArguments, " ");
    _writer.print("{");
    visitList2(node.entries, ", ");
    _writer.print("}");
    return null;
  }
  Object visitMapLiteralEntry(MapLiteralEntry node) {
    visit(node.key);
    _writer.print(" : ");
    visit(node.value);
    return null;
  }
  Object visitMethodDeclaration(MethodDeclaration node) {
    visit5(node.externalKeyword, " ");
    visit5(node.modifierKeyword, " ");
    visit2(node.returnType, " ");
    visit5(node.propertyKeyword, " ");
    visit5(node.operatorKeyword, " ");
    visit(node.name);
    if (!node.isGetter()) {
      visit(node.parameters);
    }
    visit4(" ", node.body);
    return null;
  }
  Object visitMethodInvocation(MethodInvocation node) {
    if (node.isCascaded()) {
      _writer.print("..");
    } else {
      visit2(node.target, ".");
    }
    visit(node.methodName);
    visit(node.argumentList);
    return null;
  }
  Object visitNamedExpression(NamedExpression node) {
    visit(node.name);
    visit3(" ", node.expression);
    return null;
  }
  Object visitNullLiteral(NullLiteral node) {
    _writer.print("null");
    return null;
  }
  Object visitParenthesizedExpression(ParenthesizedExpression node) {
    _writer.print('(');
    visit(node.expression);
    _writer.print(')');
    return null;
  }
  Object visitPartDirective(PartDirective node) {
    _writer.print("part ");
    visit(node.partUri);
    _writer.print(';');
    return null;
  }
  Object visitPartOfDirective(PartOfDirective node) {
    _writer.print("part of ");
    visit(node.libraryName);
    _writer.print(';');
    return null;
  }
  Object visitPostfixExpression(PostfixExpression node) {
    visit(node.operand);
    _writer.print(node.operator.lexeme);
    return null;
  }
  Object visitPrefixedIdentifier(PrefixedIdentifier node) {
    visit(node.prefix);
    _writer.print('.');
    visit(node.identifier);
    return null;
  }
  Object visitPrefixExpression(PrefixExpression node) {
    _writer.print(node.operator.lexeme);
    visit(node.operand);
    return null;
  }
  Object visitPropertyAccess(PropertyAccess node) {
    if (node.isCascaded()) {
      _writer.print("..");
    } else {
      visit(node.target);
      _writer.print('.');
    }
    visit(node.propertyName);
    return null;
  }
  Object visitRedirectingConstructorInvocation(RedirectingConstructorInvocation node) {
    _writer.print("this");
    visit3(".", node.constructorName);
    visit(node.argumentList);
    return null;
  }
  Object visitReturnStatement(ReturnStatement node) {
    Expression expression14 = node.expression;
    if (expression14 == null) {
      _writer.print("return;");
    } else {
      _writer.print("return ");
      expression14.accept(this);
      _writer.print(";");
    }
    return null;
  }
  Object visitScriptTag(ScriptTag node) {
    _writer.print(node.scriptTag.lexeme);
    return null;
  }
  Object visitShowCombinator(ShowCombinator node) {
    _writer.print("show ");
    visitList2(node.shownNames, ", ");
    return null;
  }
  Object visitSimpleFormalParameter(SimpleFormalParameter node) {
    visit5(node.keyword, " ");
    visit2(node.type, " ");
    visit(node.identifier);
    return null;
  }
  Object visitSimpleIdentifier(SimpleIdentifier node) {
    _writer.print(node.token.lexeme);
    return null;
  }
  Object visitSimpleStringLiteral(SimpleStringLiteral node) {
    _writer.print(node.literal.lexeme);
    return null;
  }
  Object visitStringInterpolation(StringInterpolation node) {
    visitList(node.elements);
    return null;
  }
  Object visitSuperConstructorInvocation(SuperConstructorInvocation node) {
    _writer.print("super");
    visit3(".", node.constructorName);
    visit(node.argumentList);
    return null;
  }
  Object visitSuperExpression(SuperExpression node) {
    _writer.print("super");
    return null;
  }
  Object visitSwitchCase(SwitchCase node) {
    visitList3(node.labels, " ", " ");
    _writer.print("case ");
    visit(node.expression);
    _writer.print(": ");
    visitList2(node.statements, " ");
    return null;
  }
  Object visitSwitchDefault(SwitchDefault node) {
    visitList3(node.labels, " ", " ");
    _writer.print("default: ");
    visitList2(node.statements, " ");
    return null;
  }
  Object visitSwitchStatement(SwitchStatement node) {
    _writer.print("switch (");
    visit(node.expression);
    _writer.print(") {");
    visitList2(node.members, " ");
    _writer.print("}");
    return null;
  }
  Object visitThisExpression(ThisExpression node) {
    _writer.print("this");
    return null;
  }
  Object visitThrowExpression(ThrowExpression node) {
    _writer.print("throw ");
    visit(node.expression);
    return null;
  }
  Object visitTopLevelVariableDeclaration(TopLevelVariableDeclaration node) {
    visit2(node.variables, ";");
    return null;
  }
  Object visitTryStatement(TryStatement node) {
    _writer.print("try ");
    visit(node.body);
    visitList4(" ", node.catchClauses, " ");
    visit3(" finally ", node.finallyClause);
    return null;
  }
  Object visitTypeArgumentList(TypeArgumentList node) {
    _writer.print('<');
    visitList2(node.arguments, ", ");
    _writer.print('>');
    return null;
  }
  Object visitTypeName(TypeName node) {
    visit(node.name);
    visit(node.typeArguments);
    return null;
  }
  Object visitTypeParameter(TypeParameter node) {
    visit(node.name);
    visit3(" extends ", node.bound);
    return null;
  }
  Object visitTypeParameterList(TypeParameterList node) {
    _writer.print('<');
    visitList2(node.typeParameters, ", ");
    _writer.print('>');
    return null;
  }
  Object visitVariableDeclaration(VariableDeclaration node) {
    visit(node.name);
    visit3(" = ", node.initializer);
    return null;
  }
  Object visitVariableDeclarationList(VariableDeclarationList node) {
    visit5(node.keyword, " ");
    visit2(node.type, " ");
    visitList2(node.variables, ", ");
    return null;
  }
  Object visitVariableDeclarationStatement(VariableDeclarationStatement node) {
    visit(node.variables);
    _writer.print(";");
    return null;
  }
  Object visitWhileStatement(WhileStatement node) {
    _writer.print("while (");
    visit(node.condition);
    _writer.print(") ");
    visit(node.body);
    return null;
  }
  Object visitWithClause(WithClause node) {
    _writer.print("with ");
    visitList2(node.mixinTypes, ", ");
    return null;
  }
  /**
   * Safely visit the given node.
   * @param node the node to be visited
   */
  void visit(ASTNode node) {
    if (node != null) {
      node.accept(this);
    }
  }
  /**
   * Safely visit the given node, printing the suffix after the node if it is non-{@code null}.
   * @param suffix the suffix to be printed if there is a node to visit
   * @param node the node to be visited
   */
  void visit2(ASTNode node, String suffix) {
    if (node != null) {
      node.accept(this);
      _writer.print(suffix);
    }
  }
  /**
   * Safely visit the given node, printing the prefix before the node if it is non-{@code null}.
   * @param prefix the prefix to be printed if there is a node to visit
   * @param node the node to be visited
   */
  void visit3(String prefix, ASTNode node) {
    if (node != null) {
      _writer.print(prefix);
      node.accept(this);
    }
  }
  /**
   * Visit the given function body, printing the prefix before if given body is not empty.
   * @param prefix the prefix to be printed if there is a node to visit
   * @param body the function body to be visited
   */
  void visit4(String prefix, FunctionBody body) {
    if (body is! EmptyFunctionBody) {
      _writer.print(prefix);
    }
    visit(body);
  }
  /**
   * Safely visit the given node, printing the suffix after the node if it is non-{@code null}.
   * @param suffix the suffix to be printed if there is a node to visit
   * @param node the node to be visited
   */
  void visit5(Token token, String suffix) {
    if (token != null) {
      _writer.print(token.lexeme);
      _writer.print(suffix);
    }
  }
  /**
   * Print a list of nodes without any separation.
   * @param nodes the nodes to be printed
   * @param separator the separator to be printed between adjacent nodes
   */
  void visitList(NodeList<ASTNode> nodes) {
    visitList2(nodes, "");
  }
  /**
   * Print a list of nodes, separated by the given separator.
   * @param nodes the nodes to be printed
   * @param separator the separator to be printed between adjacent nodes
   */
  void visitList2(NodeList<ASTNode> nodes, String separator) {
    if (nodes != null) {
      int size3 = nodes.length;
      for (int i = 0; i < size3; i++) {
        if (i > 0) {
          _writer.print(separator);
        }
        nodes[i].accept(this);
      }
    }
  }
  /**
   * Print a list of nodes, separated by the given separator.
   * @param nodes the nodes to be printed
   * @param separator the separator to be printed between adjacent nodes
   * @param suffix the suffix to be printed if the list is not empty
   */
  void visitList3(NodeList<ASTNode> nodes, String separator, String suffix) {
    if (nodes != null) {
      int size4 = nodes.length;
      if (size4 > 0) {
        for (int i = 0; i < size4; i++) {
          if (i > 0) {
            _writer.print(separator);
          }
          nodes[i].accept(this);
        }
        _writer.print(suffix);
      }
    }
  }
  /**
   * Print a list of nodes, separated by the given separator.
   * @param prefix the prefix to be printed if the list is not empty
   * @param nodes the nodes to be printed
   * @param separator the separator to be printed between adjacent nodes
   */
  void visitList4(String prefix, NodeList<ASTNode> nodes, String separator) {
    if (nodes != null) {
      int size5 = nodes.length;
      if (size5 > 0) {
        _writer.print(prefix);
        for (int i = 0; i < size5; i++) {
          if (i > 0) {
            _writer.print(separator);
          }
          nodes[i].accept(this);
        }
      }
    }
  }
}
/**
 * Instances of the class {@code NodeList} represent a list of AST nodes that have a common parent.
 */
class NodeList<E extends ASTNode> extends ListWrapper<E> {
  /**
   * The node that is the parent of each of the elements in the list.
   */
  ASTNode owner;
  /**
   * The elements of the list.
   */
  List<E> elements = new List<E>();
  /**
   * Initialize a newly created list of nodes to be empty.
   * @param owner the node that is the parent of each of the elements in the list
   */
  NodeList(ASTNode this.owner);
  /**
   * Use the given visitor to visit each of the nodes in this list.
   * @param visitor the visitor to be used to visit the elements of this list
   */
  accept(ASTVisitor visitor) {
    for (E element in elements) {
      element.accept(visitor);
    }
  }
  void add(E node) {
    owner.becomeParentOf(node);
    elements.add(node);
  }
  bool addAll(Collection<E> nodes) {
    if (nodes != null) {
      super.addAll(nodes);
      return true;
    }
    return false;
  }
  /**
   * Return the first token included in this node's source range.
   * @return the first token included in this node's source range
   */
  Token get beginToken {
    if (elements.isEmpty) {
      return null;
    }
    return elements[0].beginToken;
  }
  /**
   * Return the last token included in this node list's source range.
   * @return the last token included in this node list's source range
   */
  Token get endToken {
    if (elements.isEmpty) {
      return null;
    }
    return elements[elements.length - 1].endToken;
  }
  /**
   * Return the node that is the parent of each of the elements in the list.
   * @return the node that is the parent of each of the elements in the list
   */
  ASTNode getOwner() {
    return owner;
  }
}