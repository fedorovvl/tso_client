.class Lair/Tsoclient/AppEntry$1;
.super Ljava/lang/Object;
.source "AppEntry.java"

# interfaces
.implements Landroid/content/DialogInterface$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lair/Tsoclient/AppEntry;->showDialog(ILjava/lang/String;II)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lair/Tsoclient/AppEntry;


# direct methods
.method constructor <init>(Lair/Tsoclient/AppEntry;)V
    .locals 0

    .prologue
    .line 163
    iput-object p1, p0, Lair/Tsoclient/AppEntry$1;->this$0:Lair/Tsoclient/AppEntry;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/content/DialogInterface;I)V
    .locals 4
    .param p1, "dialog"    # Landroid/content/DialogInterface;
    .param p2, "which"    # I

    .prologue
    const/4 v3, 0x1

    .line 166
    iget-object v0, p0, Lair/Tsoclient/AppEntry$1;->this$0:Lair/Tsoclient/AppEntry;

    invoke-static {v0}, Lair/Tsoclient/AppEntry;->access$000(Lair/Tsoclient/AppEntry;)V

    .line 167
    invoke-static {}, Lair/Tsoclient/AppEntry;->access$100()Lair/Tsoclient/AppEntry;

    move-result-object v0

    invoke-static {}, Lair/Tsoclient/AppEntry;->access$200()Ljava/lang/String;

    move-result-object v1

    const/4 v2, 0x0

    invoke-static {v0, v1, v3, v2, v3}, Lcom/adobe/air/InstallOfferPingUtils;->PingAndExit(Landroid/app/Activity;Ljava/lang/String;ZZZ)V

    .line 168
    return-void
.end method
