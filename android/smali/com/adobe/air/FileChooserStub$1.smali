.class Lcom/adobe/air/FileChooserStub$1;
.super Ljava/lang/Object;
.source "FileChooserStub.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/adobe/air/FileChooserStub;->show(Ljava/lang/String;ZZ)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/adobe/air/FileChooserStub;

.field final synthetic val$f_defaultPath:Ljava/lang/String;

.field final synthetic val$f_fsObject:Lcom/adobe/air/FileChooserStub;

.field final synthetic val$f_multipleSelection:Z

.field final synthetic val$f_save:Z


# direct methods
.method constructor <init>(Lcom/adobe/air/FileChooserStub;ZZLjava/lang/String;Lcom/adobe/air/FileChooserStub;)V
    .locals 0
    .param p1, "this$0"    # Lcom/adobe/air/FileChooserStub;

    .prologue
    .line 50
    iput-object p1, p0, Lcom/adobe/air/FileChooserStub$1;->this$0:Lcom/adobe/air/FileChooserStub;

    iput-boolean p2, p0, Lcom/adobe/air/FileChooserStub$1;->val$f_save:Z

    iput-boolean p3, p0, Lcom/adobe/air/FileChooserStub$1;->val$f_multipleSelection:Z

    iput-object p4, p0, Lcom/adobe/air/FileChooserStub$1;->val$f_defaultPath:Ljava/lang/String;

    iput-object p5, p0, Lcom/adobe/air/FileChooserStub$1;->val$f_fsObject:Lcom/adobe/air/FileChooserStub;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 7

    .prologue
    .line 53
    iget-object v6, p0, Lcom/adobe/air/FileChooserStub$1;->this$0:Lcom/adobe/air/FileChooserStub;

    new-instance v0, Lcom/adobe/air/AIRExpandableFileChooser;

    iget-object v1, p0, Lcom/adobe/air/FileChooserStub$1;->this$0:Lcom/adobe/air/FileChooserStub;

    invoke-static {v1}, Lcom/adobe/air/FileChooserStub;->access$100(Lcom/adobe/air/FileChooserStub;)Ljava/util/ArrayList;

    move-result-object v1

    iget-boolean v2, p0, Lcom/adobe/air/FileChooserStub$1;->val$f_save:Z

    iget-boolean v3, p0, Lcom/adobe/air/FileChooserStub$1;->val$f_multipleSelection:Z

    iget-object v4, p0, Lcom/adobe/air/FileChooserStub$1;->val$f_defaultPath:Ljava/lang/String;

    iget-object v5, p0, Lcom/adobe/air/FileChooserStub$1;->val$f_fsObject:Lcom/adobe/air/FileChooserStub;

    invoke-direct/range {v0 .. v5}, Lcom/adobe/air/AIRExpandableFileChooser;-><init>(Ljava/util/ArrayList;ZZLjava/lang/String;Lcom/adobe/air/FileChooserStub;)V

    invoke-static {v6, v0}, Lcom/adobe/air/FileChooserStub;->access$002(Lcom/adobe/air/FileChooserStub;Lcom/adobe/air/AIRExpandableFileChooser;)Lcom/adobe/air/AIRExpandableFileChooser;

    .line 54
    iget-object v0, p0, Lcom/adobe/air/FileChooserStub$1;->this$0:Lcom/adobe/air/FileChooserStub;

    invoke-static {v0}, Lcom/adobe/air/FileChooserStub;->access$000(Lcom/adobe/air/FileChooserStub;)Lcom/adobe/air/AIRExpandableFileChooser;

    move-result-object v0

    invoke-virtual {v0}, Lcom/adobe/air/AIRExpandableFileChooser;->GetDialog()Lcom/adobe/air/AndroidAlertDialog;

    move-result-object v0

    invoke-virtual {v0}, Lcom/adobe/air/AndroidAlertDialog;->show()V

    .line 55
    return-void
.end method
