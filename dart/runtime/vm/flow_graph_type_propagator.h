// Copyright (c) 2013, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

#ifndef VM_FLOW_GRAPH_TYPE_PROPAGATOR_H_
#define VM_FLOW_GRAPH_TYPE_PROPAGATOR_H_

#include "vm/flow_graph.h"
#include "vm/intermediate_language.h"

namespace dart {

class FlowGraphTypePropagator : public FlowGraphVisitor {
 public:
  explicit FlowGraphTypePropagator(FlowGraph* flow_graph);

  void Propagate();

 private:
  void PropagateRecursive(BlockEntryInstr* block);

  void VisitValue(Value* value);

  virtual void VisitJoinEntry(JoinEntryInstr* instr);
  virtual void VisitCheckSmi(CheckSmiInstr* instr);
  virtual void VisitCheckClass(CheckClassInstr* instr);

  // Current reaching type of the definition. Valid only during dominator tree
  // traversal.
  CompileType* TypeOf(Definition* def);

  // Mark definition as having given compile type in all dominated instructions.
  void SetTypeOf(Definition* def, CompileType* type);

  // Mark definition as having given class id in all dominated instructions.
  void SetCid(Definition* value, intptr_t cid);

  void AddToWorklist(Definition* defn);
  Definition* RemoveLastFromWorklist();

  FlowGraph* flow_graph_;

  // Mapping between SSA values and their current reaching types. Valid
  // only during dominator tree traversal.
  GrowableArray<CompileType*> types_;

  // Worklist for fixpoint computation.
  GrowableArray<Definition*> worklist_;
  BitVector* in_worklist_;

  // RollbackEntry is used to track and rollback changed in the types_ array
  // done during dominator tree traversal.
  class RollbackEntry {
   public:
    // Default constructor needed for the container.
    RollbackEntry()
        : index_(), type_() {
    }

    RollbackEntry(intptr_t index, CompileType* type)
        : index_(index), type_(type) {
    }

    intptr_t index() const { return index_; }
    CompileType* type() const { return type_; }

   private:
    intptr_t index_;
    CompileType* type_;
  };

  GrowableArray<RollbackEntry> rollback_;
};

}  // namespace dart

#endif  // VM_FLOW_GRAPH_TYPE_PROPAGATOR_H_